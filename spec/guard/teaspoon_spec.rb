require "spec_helper"
require "guard/teaspoon"

describe Guard::Teaspoon do

  subject { Guard::Teaspoon.new({}) }

  before do
    Guard::Teaspoon::Resolver.stub(:new)
    Guard::Teaspoon::Runner.stub(:new)
  end

  describe "#initialize" do
    it "merges the options" do
      options = { focus_on_failed: true, other_option: 'foo' }
      subject = Guard::Teaspoon.new(options)
      expect(subject.instance_variable_get(:@options)).to eql({
        focus_on_failed:      true,
        all_after_pass:       true,
        all_on_start:         true,
        keep_failed:          true,
        formatters:           'clean',
        run_all:              {},
        run_on_modifications: {},
        other_option:         'foo'
      })
    end
  end

  describe "#start" do
    before do
      subject.stub(:run_all)
      Guard::UI.stub(:info)
    end

    it "calls reload" do
      Guard::Teaspoon.any_instance.should_receive(:reload)
      subject.start
    end

    it "creates a resolver, and a runner" do
      Guard::Teaspoon::Resolver.should_receive(:new)
      Guard::Teaspoon::Runner.should_receive(:new)
      subject.start
    end

    it "logs that we're starting" do
      Guard::UI.should_receive(:info).with("Guard::Teaspoon is running")
      subject.start
    end

    it "calls #run_all if we're supposed to" do
      subject.should_receive(:run_all)
      subject.start
    end

    it "doesn't run all if we're not supposed to" do
      subject.instance_variable_set(:@options, {all_on_start: false})
      subject.should_not_receive(:run_all)
      subject.start
    end

  end

  describe "#run_all" do
    let(:runner) { double(run_all: nil) }

    before do
      subject.runner = runner
    end

    it "calls #run_all on the runner" do
      runner.should_receive(:run_all).and_return(true)
      subject.run_all
    end

    it "resets failed_paths if all tests passed" do
      subject.failed_paths = ["1", "2"]
      runner.should_receive(:run_all).and_return(true)
      subject.run_all
      expect(subject.failed_paths).to eq([])
    end

    it "throws :task_has_failed if the tests didn't pass" do
      runner.should_receive(:run_all).and_return(false)
      expect { subject.run_all }.to raise_error(ArgumentError)
    end

  end

  describe "#reload" do

    it "resets last_failed, and failed_paths" do
      subject.last_failed = true
      subject.failed_paths = ["1", "2"]
      subject.reload
      expect(subject.last_failed).to eq(false)
      expect(subject.failed_paths).to eq([])
    end

  end

  describe "#run_on_modifications" do
    let(:resolver) { double() }
    let(:runner) { double() }
    let(:original_paths) { ["a_spec"] }

    before do
      subject.resolver = resolver
      subject.runner = runner
    end

    it "does nothing if the spec paths cant be resolved" do
      subject.last_failed = false

      resolver.should_receive(:resolve).with(original_paths)
      resolver.should_receive(:suites).and_return([])

      subject.run_on_modifications(original_paths)
    end

    it "runs every suite that is resolved to a spec" do
      subject.last_failed = false

      resolver.should_receive(:resolve).with(original_paths)
      resolver.should_receive(:suites).and_return({"default" => ["foo", "bar"], "another_suite" => ["a_spec"]})

      runner.should_receive(:run).with(["foo", "bar"], {suite: "default"}).and_return(true)
      runner.should_receive(:run).with(["a_spec"], {suite: "another_suite"}).and_return(true)

      subject.run_on_modifications(original_paths)
    end

    it "sets last_failed to false and throws :task_has_failed if a spec fails" do
      subject.last_failed = false

      resolver.should_receive(:resolve)
      resolver.should_receive(:suites).and_return({"default" => ["foo", "bar"]})

      runner.should_receive(:run).and_return(false)

      expect { subject.run_on_modifications(original_paths) }.to throw_symbol(:task_has_failed)
      expect(subject.last_failed).to eq(true)
    end

    it "if all specs pass, it calls run_all if the previous run was unsuccessful" do
      subject.last_failed = true

      resolver.should_receive(:resolve)
      resolver.should_receive(:suites).and_return({"default" => ["foo", "bar"]})

      runner.should_receive(:run).and_return(true)
      runner.should_receive(:run_all).and_return(true)

      subject.run_on_modifications(original_paths)
    end

  end

end

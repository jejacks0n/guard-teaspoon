require "spec_helper"
require "teaspoon/console"

describe Guard::Teaspoon::Runner do

  before do
    allow(Teaspoon::Console).to receive(:new)
  end

  describe "#initialize" do

    it "assigns options" do
      options = {foo: "bar"}
      subject = Guard::Teaspoon::Runner.new(options)
      expect(subject.instance_variable_get(:@options)).to be(options)
    end

    it "aborts with a message on Teaspoon::EnvironmentNotFound" do
      allow(Teaspoon::Console).to receive(:new) { raise Teaspoon::EnvironmentNotFound, {} }
      expect_any_instance_of(Guard::Teaspoon::Runner).to receive(:abort)
      expect(STDOUT).to receive(:print).with("Unable to load Teaspoon environment in {spec/teaspoon_env.rb, test/teaspoon_env.rb, teaspoon_env.rb}.\n")
      expect(STDOUT).to receive(:print).with("Consider using -r path/to/teaspoon_env\n")
      Guard::Teaspoon::Runner.new
    end

  end

  describe "#run_all" do

    let(:console) { double(execute: nil) }

    before do
      subject.console = console
      subject.instance_variable_set(:@options, {foo: "bar"})
    end

    it "calls execute on console" do
      expect(console).to receive(:execute).with({foo: "bar", baz: "teaspoon"})
      subject.run_all(baz: "teaspoon")
    end

    it 'removes previously set files so that all files are run' do
      subject = Guard::Teaspoon::Runner.new(files: ["file1", "file2"], baz: "teaspoon")
      subject.console = console
      expect(console).to receive(:execute).with(foo: "bar", baz: "teaspoon")
      subject.run_all(foo: "bar")
    end

  end

  describe "#run" do

    let(:console) { double(execute: nil) }

    before do
      subject.console = console
      subject.instance_variable_set(:@options, {foo: "bar"})
    end

    it "calls execute on console" do
      files = ["file1", "file2"]
      expect(console).to receive(:execute).with({foo: "bar", baz: "teaspoon", files: files})
      subject.run(files, baz: "teaspoon")
    end

    it "does nothing if there's no paths" do
      expect(console).to_not receive(:execute)
      subject.run([], baz: "teaspoon")
    end

  end

end

require "spec_helper"
require "teabag/console"

describe Guard::Teabag::Runner do

  before do
    Teabag::Console.stub(:new)
  end

  describe "#initialize" do

    it "assigns options" do
      options = {foo: "bar"}
      subject = Guard::Teabag::Runner.new(options)
      expect(subject.instance_variable_get(:@options)).to be(options)
    end

    it "aborts with a message on Teabag::EnvironmentNotFound" do
      Teabag::Console.should_receive(:new).and_raise(Teabag::EnvironmentNotFound)
      Guard::Teabag::Runner.any_instance.should_receive(:abort)
      STDOUT.should_receive(:print).with("Unable to load Teabag environment in {spec/teabag_env.rb, test/teabag_env.rb, teabag_env.rb}.\n")
      STDOUT.should_receive(:print).with("Consider using -r path/to/teabag_env\n")
      Guard::Teabag::Runner.new
    end

  end

  describe "#run_all" do

    let(:console) { mock(execute: nil) }

    before do
      subject.console = console
      subject.instance_variable_set(:@options, {foo: "bar"})
    end

    it "calls execute on console" do
      console.should_receive(:execute).with({foo: "bar", baz: "teabag"})
      subject.run_all(baz: "teabag")
    end

  end

  describe "#run" do

    let(:console) { mock(execute: nil) }

    before do
      subject.console = console
      subject.instance_variable_set(:@options, {foo: "bar"})
    end

    it "calls execute on console" do
      paths = ["1", "2"]
      console.should_receive(:execute).with({foo: "bar", baz: "teabag"}, paths)
      subject.run(paths, baz: "teabag")
    end

    it "does nothing if there's no paths" do
      console.should_not_receive(:execute)
      subject.run([], baz: "teabag")
    end

  end

end

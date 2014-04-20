require "spec_helper"
require "teaspoon/console"

describe Guard::Teaspoon::Runner do

  before do
    Teaspoon::Console.stub(:new)
  end

  describe "#initialize" do

    it "assigns options" do
      options = {foo: "bar"}
      subject = Guard::Teaspoon::Runner.new(options)
      expect(subject.instance_variable_get(:@options)).to be(options)
    end

    it "aborts with a message on Teaspoon::EnvironmentNotFound" do
      Teaspoon::Console.should_receive(:new).and_raise(Teaspoon::EnvironmentNotFound)
      Guard::Teaspoon::Runner.any_instance.should_receive(:abort)
      STDOUT.should_receive(:print).with("Unable to load Teaspoon environment in {spec/teaspoon_env.rb, test/teaspoon_env.rb, teaspoon_env.rb}.\n")
      STDOUT.should_receive(:print).with("Consider using -r path/to/teaspoon_env\n")
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
      console.should_receive(:execute).with({foo: "bar", baz: "teaspoon"})
      subject.run_all(baz: "teaspoon")
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
      console.should_receive(:execute).with({foo: "bar", baz: "teaspoon", files: files})
      subject.run(files, baz: "teaspoon")
    end

    it "does nothing if there's no paths" do
      console.should_not_receive(:execute)
      subject.run([], baz: "teaspoon")
    end

  end

end

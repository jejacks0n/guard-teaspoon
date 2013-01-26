require "spec_helper"
require "teabag/console"

describe Guard::Teabag::Resolver do

  describe "#initialize" do

    it "assigns options" do
      options = {foo: "bar"}
      subject = Guard::Teabag::Resolver.new(options)
      expect(subject.instance_variable_get(:@options)).to be(options)
    end

  end

  describe "#resolve" do

    it "calls through to Teabag::Suite to resolve paths and assigns them to suites" do
      Teabag::Suite.should_receive(:resolve_spec_for).with("foo").and_return(suite: "default", path: "foo")
      Teabag::Suite.should_receive(:resolve_spec_for).with("bar").and_return(suite: "default", path: "bar")
      Teabag::Suite.should_receive(:resolve_spec_for).with("baz").and_return(suite: "other", path: "baz")
      subject.resolve(["foo", "bar", "baz"])
      expect(subject.suites).to eq({"default" => ["foo", "bar"], "other" => ["baz"]})
    end

  end

end

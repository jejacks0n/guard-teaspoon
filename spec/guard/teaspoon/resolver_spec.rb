require "spec_helper"
require "teaspoon/console"

describe Guard::Teaspoon::Resolver do

  describe "#initialize" do

    it "assigns options" do
      options = {foo: "bar"}
      subject = Guard::Teaspoon::Resolver.new(options)
      expect(subject.instance_variable_get(:@options)).to be(options)
    end

  end

  describe "#resolve" do

    it "calls through to Teaspoon::Suite to resolve paths and assigns them to suites" do
      expect(Teaspoon::Suite).to receive(:resolve_spec_for).with("foo").and_return(suite: "default", path: "foo")
      expect(Teaspoon::Suite).to receive(:resolve_spec_for).with("bar").and_return(suite: "default", path: "bar")
      expect(Teaspoon::Suite).to receive(:resolve_spec_for).with("baz").and_return(suite: "other", path: "baz")
      subject.resolve(["foo", "bar", "baz"])
      expect(subject.suites).to eq({"default" => ["foo", "bar"], "other" => ["baz"]})
    end

    it "resolves directories" do
      paths = ["spec/javascripts/my_test_spec.js", "spec/javascripts/my_other_test_spec.js"]
      expect(Teaspoon::Suite).to receive(:resolve_spec_for).and_return(suite: 'default', path: paths)
      subject.resolve([ 'spec/javascripts' ])
      expect(subject.suites).to eq({"default" => paths})
    end

  end

end

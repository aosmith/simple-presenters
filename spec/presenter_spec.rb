require 'spec_helper'

class Hash
  def symbolize_keys
    keys.inject({}) do |object_hash, key|
      object_hash[key.to_sym] = self.send(:[], key)
      object_hash
    end
  end
end

module SimplePresenters
  module Tests
    module TestObjectPresenter
      include SimplePresenters::Presenter
      def default
        [:clear_param, :extra_param]
      end

      def method_test
        [:clear_param, :method_param_test]
      end
    end
    class TestObject
      include TestObjectPresenter

      attr_accessor :filtered_param, :clear_param, :extra_param, :test_param

      def self.filtered_parameters
        [:filtered_param]
      end

      def attributes
        { "filtered_param" => self.filtered_param, "clear_param" => self.clear_param, "extra_param" => self.extra_param, "test_param" => 'test_param' }
      end

      def initialize
        self.filtered_param = "this param should not be exposed"
        self.clear_param = "this one should be"
        self.extra_param = "an extra param"
        self.test_param = "a test param"
      end

      def method_param_test
        "Hello World"
      end
    end
  end
end

describe "stub" do
  it "should pass" do
    # pass
  end
end

describe "Tests using PORO" do

  before(:all) do
    @test_object = SimplePresenters::Tests::TestObject.new
  end

  it "should not expose protected attributes" do
    p = @test_object.present_as(:all)
    p.keys.should_not include(:filtered_param)
  end

  it "should expose unprotected attributes by default" do
    p = @test_object.present_as(:all)
    p.keys.should include(:clear_param)
    p.keys.should include(:extra_param)
    p.keys.should include(:test_param)
  end

  it "should not return extra attributes" do
    p = @test_object.present_as(:default)
    p.keys.should include(:clear_param)
    p.keys.should include(:extra_param)
    p.keys.should_not include(:filtered_param)
    p.keys.should_not include(:test_param)
  end

  it "should be able to use methods" do
    p = @test_object.present_as(:method_test)
    p.keys.should include(:clear_param)
    p.keys.should include(:method_param_test)
    p[:method_param_test].should eq("Hello World")
  end

end

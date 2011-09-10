# -*- encoding : utf-8 -*
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MyResource
  extend Resource

  @resource = "test_resource"
end

describe Resource do
  before(:each) do
    Configuration.http_library_adapter = double("an http library adapter").as_null_object
  end

  let(:request_handler) { double.as_null_object }

  context "fetching the resource's details" do
    it "uses the correct resource name" do
      Request.should_receive(:new).with("test_resource/1").and_return(request_handler)

      MyResource.details(1)
    end

    it "delegates the GET request to the request handler" do
      Request.stub(:new).and_return(request_handler)
      request_handler.should_receive(:get).and_return({})

      MyResource.details(1)
    end
  end
end

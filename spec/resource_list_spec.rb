# -*- encoding : utf-8 -*
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MyResourceList
  extend ResourceList

  @resource = "test_resource_list"

  class << self
    attr_accessor :another_parameter
  end

  def self.include_additional_parameters
    params[:another_parameter] = another_parameter unless another_parameter.nil?
  end
end

describe ResourceList do
  before(:each) do
    Configuration.http_library_adapter = double("an http library adapter").as_null_object
  end

  let(:request_handler) { double.as_null_object }

  context "fetching the resource list" do
    it "uses the correct list name" do
      Request.should_receive(:new).with("test_resource_list", anything).and_return(request_handler)

      MyResourceList.fetch
    end

    it "passes the default pagination params when none are supplied" do
      Request.should_receive(:new).with(anything, {:page_number=>1, :per_page=>100}).and_return(request_handler)

      MyResourceList.fetch
    end

    it "passes the pagination parameters to the request handler" do
      Request.should_receive(:new).with(anything, {:page_number=>4, :per_page=>10}).and_return(request_handler)

      MyResourceList.fetch(4, 10)
    end

    it "includes all additional params as defined by the extending class" do
      MyResourceList.another_parameter = "test_param"
      Request.should_receive(:new).with(anything, {:another_parameter => "test_param", :page_number=>1, :per_page=>100}).and_return(request_handler)

      MyResourceList.fetch
    end

    it "delegates the GET request to the request handler" do
      Request.stub(:new).and_return(request_handler)
      request_handler.should_receive(:get).and_return({})

      MyResourceList.fetch
    end
  end
end

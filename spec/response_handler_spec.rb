# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ResponseHandler do
  context "processing a successful response" do
    context "for a single resource" do
      let(:json_from_api)  { File.open("#{FIXTURES_PATH}/resource_get_success.json").read }
      let(:raw_response)   { OpenStruct.new(:body => json_from_api, :code => 200) }
      let(:processed_data) { subject.process(raw_response) }

      it "returns a Hashie::Mash" do
        processed_data.should be_an_instance_of(Hashie::Mash)
      end

      it "returns the resource's data" do
        processed_data.name.should eq("BioShock")
      end
    end

    context "for a collection of resources" do
      let(:json_from_api)  { File.open("#{FIXTURES_PATH}/resource_list_get_success.json").read }
      let(:raw_response)   { OpenStruct.new(:body => json_from_api, :code => 200) }
      let(:processed_data) { subject.process(raw_response) }

      it "returns an Array" do
        processed_data.should be_an_instance_of(Array)
      end

      it "returns the correct amount of entities" do
        processed_data.should have(10).items
      end

      it "returns the correct data for the resources in the list" do
        processed_data.first.name.should eq("Blackjack")
      end
    end
  end

  context "processing an unsuccessful response" do
    let(:logger) { double("a logger").as_null_object }
    before(:each) { Configuration.logger = logger }

    context "when the response is nil" do
      it "raises an error" do
        expect { subject.process(nil) }.to raise_error(Errors::UnrecognizedResponseError)
      end
    end

    context "when the response code isn't 200" do
      let(:raw_response)   { OpenStruct.new(:code => 500) }

      it "raises an error" do
        expect { subject.process(raw_response) }.to raise_error(Errors::RequestFailedError)
      end

      it "logs the error" do
        logger.should_receive(:info)

        subject.process(raw_response) rescue []
      end
    end

    context "when the request is successful but the API call is invalid" do
      let(:json_from_api)  { File.open("#{FIXTURES_PATH}/resource_get_fail.json").read }
      let(:raw_response)   { OpenStruct.new(:body => json_from_api, :code => 200) }

      it "raises an error" do
        expect { subject.process(raw_response) }.to raise_error(Errors::InvalidRequestError)
      end

      it "logs the error" do
        logger.should_receive(:info)

        subject.process(raw_response) rescue []
      end

    end
  end
end

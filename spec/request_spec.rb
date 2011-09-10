# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Request do
  let(:http_client) { double("an http client").as_null_object }
  let(:return_json) { File.new("#{FIXTURES_PATH}/resource_get_success.json") }
  let(:fake_handler) { double("a response handler").as_null_object }

  before(:each) do
    Configuration.api_key = "key"
    Configuration.http_library_adapter = http_client
  end

  context "issuing a GET request" do
    it "correctly builds the URL with the default params" do
      request = Request.new("games", {})
      http_client.should_receive(:http_get)
        .with("#{Configuration::BASE_URL}/games/?format=json&api_key=key")

      request.get(fake_handler)
    end

    it "correctly builds the request params" do
      request = Request.new("games", {:test_param => "test"})
      http_client.should_receive(:http_get)
        .with("#{Configuration::BASE_URL}/games/?format=json&api_key=key&test_param=test")

      request.get(fake_handler)
    end

    it "sends the pagination params" do
      request = Request.new("games", {:per_page => 50, :page_number => 2})
      http_client.should_receive(:http_get)
        .with("#{Configuration::BASE_URL}/games/?format=json&api_key=key&limit=50&offset=50")

      request.get(fake_handler)
    end

    it "logs the requested URL" do
      logger = double("a logger")
      Configuration.logger = logger
      request = Request.new("games", {})

      logger.should_receive(:info).with(/GET on/)

      request.get(fake_handler)
    end
  end
end

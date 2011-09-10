# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# The adapter should break in case someone changes the calls to Curb, so this spec is totally API-bound
describe CurbAdapter do
  context "issuing an HTTP GET request" do
    let(:url) { "http://www.google.com.br/" }

    before(:each) do
      stub_request(:get, url).to_return(:status => 200)
    end

    it "calls Curl::Easy.http_get" do
      Curl::Easy.should_receive(:http_get).with(url)

      CurbAdapter.http_get(url)
    end

    it "uses the supplied headers" do
      request = CurbAdapter.http_get(url, :test_header => "test")

      request.headers.should include({:test_header => "test"})
    end
  end
end

# -*- encoding : utf-8 -*-
require "ostruct"

module BombDefuser
  class CurbAdapter
    def self.http_get(url, headers = {})
      begin
        response = Curl::Easy.http_get(url) {|config| config.headers = headers }

        if response
          OpenStruct.new(:body => response.body_str, :code => response.response_code, :headers => response.headers)
        end
      rescue StandardError => e
        raise Errors::WebServiceNotAvailableError, e.message
      end
    end
  end
end

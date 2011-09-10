# -*- encoding: utf-8 -*-
require "logger"

module BombDefuser
  class Configuration
    BASE_URL = "http://api.giantbomb.com"

    @http_library_adapter = CurbAdapter
    @logger = Logger.new(STDOUT)

    class << self
      attr_accessor :api_key, :http_library_adapter, :logger
    end
  end
end

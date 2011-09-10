# -*- encoding: utf-8 -*-
module BombDefuser
  class Request
    def initialize(resource, params = {})
      self.request_url = "#{Configuration::BASE_URL}/#{resource}/"
      self.request_params = build_params(params)
      self.logger = Configuration.logger
      self.http_client = Configuration.http_library_adapter
    end

    def get(response_handler = ResponseHandler.new)
      url = build_url
      logger.info("GET on #{url}")

      response = http_client.http_get(url)
      response_handler.process(response)
    end

    private
    attr_accessor :http_client, :logger, :request_url, :request_params

    def build_params(params)
      building_params = {:format => "json", :api_key => Configuration.api_key}

      if limit = params.delete(:per_page)
        building_params[:limit] = limit
        building_params[:offset] = (params.delete(:page_number) - 1) * limit
      end

      building_params.merge!(params)
      building_params
    end

    def build_url
      params = request_params.inject([]) do |memo, param_pair|
        memo << "#{param_pair[0]}=#{param_pair[1]}"
      end

      building_url = request_url.dup
      building_url << "?#{params.join('&')}"
    end
  end
end

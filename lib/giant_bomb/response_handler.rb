# -*- encoding: utf-8 -*-
module GiantBomb
  class ResponseHandler
    def initialize(parser = Yajl::Parser.new)
      self.parser = parser
      self.logger = Configuration.logger
    end

    def process(response)
      raise(Errors::UnrecognizedResponseError, "The response can't be nil") if response.nil?

      parse(response, parser)
      result_size > 1 ? process_collection : process_single_resource
    end

    private
    attr_accessor :logger, :parser, :result_size, :results

    def parse(response, parser)
      if valid_response?(response)
        parsed_response = parser.parse(response.body)
        handle_api_details(parsed_response)
      else
        raise Errors::UnrecognizedResponseError, "Your request didn't return a standard response from GiantBomb's API. Please check the log."
      end
    end

    def valid_response?(response)
      if response.code == 200
        true
      else
        logger.info("Request failed. Http status: #{response.code}. Body: #{response.body}")
        raise Errors::RequestFailedError, "The request failed with http code #{response.code}"
      end
    end

    def handle_api_details(parsed_response)
      if parsed_response["status_code"] == 1
        self.result_size = parsed_response["number_of_page_results"]
        self.results = parsed_response["results"]
      else
        logger.info("The API returned an error: #{parsed_response["error"]}")
        raise Errors::InvalidRequestError, parsed_response["error"]
      end
    end

    def process_collection
      results.inject([]) do |collection, element|
        collection << Hashie::Mash.new(element)
      end
    end

    def process_single_resource
      Hashie::Mash.new(results)
    end
  end
end

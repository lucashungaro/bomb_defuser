# -*- encoding: utf-8 -*-
module GiantBomb
  module Errors
    class InvalidRequestError < StandardError; end
    class RequestFailedError < StandardError; end
    class UnrecognizedResponseError < StandardError; end
    class WebServiceNotAvailableError < StandardError; end
  end
end

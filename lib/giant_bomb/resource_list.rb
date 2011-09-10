# -*- encoding: utf-8 -*-
module GiantBomb
  module ResourceList
    def fetch(page_number = 1, per_page = 100)
      self.params = {:page_number => page_number, :per_page => per_page}
      include_additional_parameters

      request = Request.new(resource, params)
      request.get
    end

    private
    attr_accessor :params, :resource
  end
end

# -*- encoding: utf-8 -*-
module GiantBomb
  module Resource
    def details(resource_id)
      request = Request.new("#{resource}/#{resource_id}")
      request.get
    end

    private
    attr_accessor :resource
  end
end

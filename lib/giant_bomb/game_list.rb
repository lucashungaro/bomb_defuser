# -*- encoding: utf-8 -*-
module GiantBomb
  class GameList
    extend ResourceList

    @resource = "games"

    class << self
      attr_accessor :platforms
    end

    def self.include_additional_parameters
      self.platforms ||= []
      params[:platforms] = platforms.join(",") unless platforms.empty?
    end
  end
end

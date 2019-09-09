# frozen_string_literal: true

require 'logger'

module RailsRoutingAnalytics
  class Config # :nodoc:
    attr_accessor :src_path, :grape_api_class, :logger

    def initialize
      @logger = Logger.new(STDOUT)
      @src_path = ENV['SRC_PATH']
      @grape_api_class = ENV['GRAPE_API_CLASS']
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module RailsRoutingAnalytics
  module ReportGenerator # :nodoc:
    def self.build(format)
      generator = "rails_routing_analytics/report_generator/#{format}".classify.safe_constantize
      raise ::RailsRoutingAnalytics::InvalidFormat, "#{format} is unsupported format" unless generator

      generator
    end
  end
end

require 'rails_routing_analytics/report_generator/base'
require 'rails_routing_analytics/report_generator/csv'

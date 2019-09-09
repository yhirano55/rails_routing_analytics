# frozen_string_literal: true

require 'set'
require 'singleton'

module RailsRoutingAnalytics
  module Routes
    class Base # :nodoc:
      include Singleton

      def find_route(path, method:)
        raise NotImplementedError, "you should implement #{self.class}##{__method__}"
      end

      def routes
        raise NotImplementedError, "you should implement #{self.class}##{__method__}"
      end

      def generate_list(format: :csv, timestamp: false)
        filename = self.class.to_s.split('::').last.downcase
        generator = ::RailsRoutingAnalytics::ReportGenerator.build(format).new(name: filename, timestamp: timestamp)
        generator.generate(routes: routes)
      end
    end
  end
end

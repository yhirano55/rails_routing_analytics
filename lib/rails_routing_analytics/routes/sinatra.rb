# frozen_string_literal: true

module RailsRoutingAnalytics
  module Routes
    class Sinatra < Base # :nodoc:
      def find_route(path, method:)
        nil
      end

      def routes
        @routes ||= Set.new
      end
    end
  end
end

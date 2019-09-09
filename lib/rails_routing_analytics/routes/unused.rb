# frozen_string_literal: true

module RailsRoutingAnalytics
  module Routes
    class Unused < Base # :nodoc:
      def find_route(path, method:)
        nil
      end

      def routes
        @routes ||= all.routes - used.routes
      end

      private

      def all
        ::RailsRoutingAnalytics::Routes::All.instance
      end

      def used
        ::RailsRoutingAnalytics::Routes::Used.instance
      end
    end
  end
end

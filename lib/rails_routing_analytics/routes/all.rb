# frozen_string_literal: true

module RailsRoutingAnalytics
  module Routes
    class All < Base # :nodoc:
      def find_route(path, method:)
        rails.find_route(path, method: method) ||
          grape.find_route(path, method: method) ||
          sinatra.find_route(path, method: method)
      end

      def routes
        @routes ||= rails.routes + sinatra.routes + grape.routes
      end

      private

      def rails
        ::RailsRoutingAnalytics::Routes::Rails.instance
      end

      def sinatra
        ::RailsRoutingAnalytics::Routes::Sinatra.instance
      end

      def grape
        ::RailsRoutingAnalytics::Routes::Grape.instance
      end
    end
  end
end

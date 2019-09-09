# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module RailsRoutingAnalytics
  module Routes
    class Grape < Base # :nodoc:
      NullApi = Class.new

      def find_route(path, method:)
        return unless valid_api_class?

        find_route_from(path, method: method)
      end

      def routes
        @routes ||= Set.new.tap do |collection|
          next unless valid_api_class?

          grape_api_class.routes.each do |api|
            path = api.path.gsub(':version', api.version)
            verb = ::RailsRoutingAnalytics.find_verb(api.request_method)
            collection << ::RailsRoutingAnalytics::Route.new(path, verb)
          end
        end
      end

      private

      def find_route_from(path, method:)
        info = grape_api_class.recognize_path(path)
        return unless info

        api = info.routes[0]
        path = api.path.gsub(':version', api.version)
        verb = ::RailsRoutingAnalytics.find_verb(method)
        ::RailsRoutingAnalytics::Route.new(path, verb)
      end

      def valid_api_class?
        grape_api_class.respond_to?(:recognize_path) && grape_api_class.respond_to?(:routes)
      end

      def grape_api_class
        @grape_api_class ||= ::RailsRoutingAnalytics.config.grape_api_class.to_s.safe_constantize || NullApi
      end
    end
  end
end

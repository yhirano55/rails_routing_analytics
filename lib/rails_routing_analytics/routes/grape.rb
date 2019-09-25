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
        api = grape_api_class.compile.router.instance_eval do
          with_optimization { match?(path, method) }
        end
        return unless api.respond_to?(:path) # 404

        path = api.path.gsub(':version', api.version)
        verb = ::RailsRoutingAnalytics.find_verb(method)
        ::RailsRoutingAnalytics::Route.new(path, verb)
      end

      def valid_api_class?
        grape_api_class.respond_to?(:compile) && grape_api_class.respond_to?(:routes)
      end

      def grape_api_class
        @grape_api_class ||= ::RailsRoutingAnalytics.config.grape_api_class.to_s.safe_constantize || NullApi
      end
    end
  end
end

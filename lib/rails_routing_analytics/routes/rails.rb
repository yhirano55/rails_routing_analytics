# frozen_string_literal: true

module RailsRoutingAnalytics
  module Routes
    class Rails < Base # :nodoc:
      def find_route(path, method:)
        route = find_route_from(path, method: method)
        return unless valid_route?(route)

        path = route.path.spec.to_s
        verb = ::RailsRoutingAnalytics.find_verb(route.verb)
        ::RailsRoutingAnalytics::Route.new(path, verb)
      end

      def routes
        @routes ||= begin
          valid_rails_application_routes.inject(Set.new) do |collection, route|
            path = route.path.spec.to_s
            verb = ::RailsRoutingAnalytics.find_verb(route.verb)
            collection << ::RailsRoutingAnalytics::Route.new(path, verb)
          end
        end
      end

      private

      def find_route_from(path, method:)
        env = ::Rack::MockRequest.env_for(path, method: method)
        req = ::ActionDispatch::Request.new(env)

        ::Rails.application.routes.router.recognize(req) do |route, _param|
          return route
        end
      end

      def valid_route?(route)
        !route.verb.empty? && !route.path.nil? && !route.internal
      end

      def valid_rails_application_routes
        ::Rails.application.routes.routes.select { |route| valid_route?(route) }
      end
    end
  end
end

# frozen_string_literal: true

require 'csv'

module RailsRoutingAnalytics
  module Routes
    class Used < Base # :nodoc:
      def find_route(path, method:)
        nil
      end

      def routes
        @routes ||= Set.new.tap do |collection|
          next unless src_path

          # Preload all routes to find routes
          all.routes

          CSV.foreach(src_path, headers: true, skip_blanks: true) do |row|
            method = row['method'] || row['verb']
            path = row['path']

            begin
              route = all.find_route(path, method: method)

              if route
                collection << route
              else
                logger.error "Not Found: #{method} #{path}"
              end
            rescue ActionController::UnknownHttpMethod, URI::InvalidURIError => e
              logger.error "#{e.class}: #{method} #{path}"
            end
          end
        end
      end

      private

      def all
        ::RailsRoutingAnalytics::Routes::All.instance
      end

      def logger
        ::RailsRoutingAnalytics.config.logger
      end

      def src_path
        ::RailsRoutingAnalytics.config.src_path
      end
    end
  end
end

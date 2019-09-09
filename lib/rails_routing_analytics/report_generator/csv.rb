# frozen_string_literal: true

require 'csv'

module RailsRoutingAnalytics
  module ReportGenerator
    class Csv < Base # :nodoc:
      def generate(routes:)
        filename = filename(format: :csv)
        File.open(filename, 'wb+') { |io| io.write generate_csv_from(routes) }
        execute_time = Time.now - initialized_at
        logger.info "Generate: #{filename} (#{execute_time} sec)"
      end

      private

      def generate_csv_from(routes)
        CSV.generate do |csv|
          csv << %w[method path]

          routes.sort_by(&:path).each do |route|
            csv << [route.verb, route.path]
          end
        end
      end
    end
  end
end

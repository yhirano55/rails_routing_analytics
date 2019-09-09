# frozen_string_literal: true

module RailsRoutingAnalytics
  module ReportGenerator
    class Base # :nodoc:
      def initialize(name:, timestamp: false)
        @name = name
        @initialized_at = Time.now
        @logger = ::RailsRoutingAnalytics.config.logger
        @timestamp = timestamp
      end

      def generate(routes:)
        raise NotImplementedError, "you should implement #{self.class}##{__method__}"
      end

      private

      attr_reader :name, :initialized_at, :logger

      def filename(format:)
        timestamp? ? initialized_at.strftime("%Y%m%d%H%M%S_#{name}_routes.#{format}") : "#{name}.#{format}"
      end

      def timestamp?
        !!@timestamp
      end
    end
  end
end

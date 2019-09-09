# frozen_string_literal: true

require 'rails'
require 'rails_routing_analytics/railtie'

module RailsRoutingAnalytics # :nodoc:
  class InvalidFormat < StandardError; end

  VERBS = {
    'GET' => 'GET',
    'POST' => 'POST',
    'PUT' => 'PUT/PATCH',
    'PATCH' => 'PUT/PATCH',
    'DELETE' => 'DELETE'
  }.freeze

  class << self
    def generate_report(format: :csv, timestamp: true)
      generate_used_routes(format: format, timestamp: timestamp)
      generate_unused_routes(format: format, timestamp: timestamp)
    end

    def generate_all_routes(format: :csv, timestamp: false)
      ::RailsRoutingAnalytics::Routes::All.instance.generate_list(format: format, timestamp: timestamp)
    end

    def generate_rails_routes(format: :csv, timestamp: false)
      ::RailsRoutingAnalytics::Routes::Rails.instance.generate_list(format: format, timestamp: timestamp)
    end

    def generate_grape_routes(format: :csv, timestamp: false)
      ::RailsRoutingAnalytics::Routes::Grape.instance.generate_list(format: format, timestamp: timestamp)
    end

    def generate_used_routes(format: :csv, timestamp: false)
      validate!
      ::RailsRoutingAnalytics::Routes::Used.instance.generate_list(format: format, timestamp: timestamp)
    end

    def generate_unused_routes(format: :csv, timestamp: false)
      validate!
      ::RailsRoutingAnalytics::Routes::Unused.instance.generate_list(format: format, timestamp: timestamp)
    end

    def find_verb(verb)
      formatted_verb = verb.to_s.upcase
      VERBS[formatted_verb] || formatted_verb
    end

    def config
      @config ||= Config.new
    end

    def configure(&block)
      block.call(config)
    end

    private

    def validate!
      raise 'you should set ENV["SRC_PATH"] or RailsRoutingAnalytics.config.src_path' unless config.src_path
    end
  end
end

require 'rails_routing_analytics/config'
require 'rails_routing_analytics/report_generator'
require 'rails_routing_analytics/route'
require 'rails_routing_analytics/routes'
require 'rails_routing_analytics/version'

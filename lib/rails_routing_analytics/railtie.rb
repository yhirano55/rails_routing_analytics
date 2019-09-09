# frozen_string_literal: true

module RailsRoutingAnalytics
  class Railtie < Rails::Engine # :nodoc:
    rake_tasks do
      load 'rails_routing_analytics/tasks.rake'
    end
  end
end

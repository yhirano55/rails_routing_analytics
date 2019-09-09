# frozen_string_literal: true

namespace :rails_routing_analytics do
  desc 'generate csv file written used/unused routes'
  task generate_report: :environment do
    RailsRoutingAnalytics.generate_report
  end

  namespace :routes do
    desc 'generate csv file written all routes'
    task all: :environment do
      RailsRoutingAnalytics.generate_all_routes(timestamp: true)
    end

    desc 'generate csv file written rails routes'
    task rails: :environment do
      RailsRoutingAnalytics.generate_rails_routes(timestamp: true)
    end

    desc 'generate csv file written grape routes'
    task grape: :environment do
      RailsRoutingAnalytics.generate_grape_routes(timestamp: true)
    end

    desc 'generate csv file written used routes'
    task used: :environment do
      RailsRoutingAnalytics.generate_used_routes(timestamp: true)
    end

    desc 'generate csv file written unused routes'
    task unused: :environment do
      RailsRoutingAnalytics.generate_unused_routes(timestamp: true)
    end
  end
end

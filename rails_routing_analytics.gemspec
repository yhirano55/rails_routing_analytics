# frozen_string_literal: true

lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_routing_analytics/version'

Gem::Specification.new do |s|
  s.name          = 'rails_routing_analytics'
  s.version       = RailsRoutingAnalytics::VERSION
  s.authors       = ['Yoshiyuki Hirano']
  s.email         = ['yhirano@me.com']

  s.homepage      = 'https://github.com/yhirano55/rails_routing_analytics'
  s.summary       = 'Compare defined routes and request logs, and generate report about routing.'
  s.description   = s.summary
  s.license       = 'MIT'
  s.files         = Dir.chdir(File.expand_path('.', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features|images)/})
    end
  end

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rails', '>= 4.2'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end

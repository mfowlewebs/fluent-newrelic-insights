# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/newrelic_insights/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-newrelic-insights"
  spec.version       = Fluent::NewrelicInsights::VERSION
  spec.authors       = ["Kazunori Kajihiro"]
  spec.email         = ["kazunori.kajihiro@gmail.com"]

  spec.summary       = %q{Fluent outplugins that forward logs to Newrelic Insights}
  spec.description   = %q{Fluent outplugins that forward logs to Newrelic Insights}
  spec.homepage      = "https:/github.com/k2nr/fluent-newrelic-insights"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "rest-client"
end

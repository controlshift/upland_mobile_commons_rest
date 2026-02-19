# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'upland_mobile_commons_rest'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.authors       = ['Kathy Lu', 'Diego Marcet', 'Grey Moore', 'Nathan Woodhull', 'Owens Ehimen']
  spec.email         = ['talk@controlshiftlabs.com']

  spec.summary       = 'API client gem for Upland Mobile Commons'
  spec.description   = 'A simple ruby API client gem for the Upland Mobile Commons REST API'
  spec.homepage      = 'https://github.com/controlshift/upland_mobile_commons_rest'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = ['>= 3.3', '< 5.0']

  # Runtime dependencies
  spec.add_runtime_dependency 'vertebrae', '~> 1.0'
  spec.add_runtime_dependency 'faraday', '~> 2.0'
  spec.add_runtime_dependency 'faraday-multipart', '~> 1.0'
  spec.add_runtime_dependency 'multi_xml', '~> 0.5'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 4.0'
  spec.add_development_dependency 'byebug', '~> 13.0'
  spec.add_development_dependency 'dotenv', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rdoc', '~> 7.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'shoulda', '~> 4.0'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'webmock', '~> 3.0'
end

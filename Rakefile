# frozen_string_literal: true

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'upland_mobile_commons_rest'
  gem.homepage = 'http://github.com/controlshift/upland_mobile_commons_rest'
  gem.license = 'MIT'
  gem.summary = %(API client gem for Upland Mobile Commons)
  gem.description = %(A simple ruby API client gem for the Upland Mobile Commons REST API)
  gem.email = 'team@controlshiftlabs.com'
  gem.authors = ['Kathy Lu', 'Diego Marcet', 'Grey Moore', 'Nathan Woodhull']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "upland_mobile_commons_rest #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

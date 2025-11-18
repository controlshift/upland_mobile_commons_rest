# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'upland_mobile_commons_rest'
require 'dotenv'
require 'byebug'

Dotenv.load('.env')

client = UplandMobileCommonsRest.new(api_key: ENV['API_KEY']) # rubocop:disable Lint/UselessAssignment

puts "Ready to call MobileCommons API using 'client' object"
byebug # rubocop:disable Lint/Debugger

puts 'Bye!'

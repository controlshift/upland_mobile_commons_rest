require_relative 'lib/upland_mobile_commons_rest'
require 'dotenv'
require 'byebug'

Dotenv.load('.env')

client = UplandMoblieCommons.new(username: ENV['USERNAME'], password: ENV['PASSWORD'] ) # rubocop:disable Lint/UselessAssignment

puts "Ready to call MobileCommons API using 'client' object"
byebug # rubocop:disable Lint/Debugger

puts "Bye!"
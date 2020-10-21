# require "bundler/setup"
# Bundler.require
# require "sinatra/activerecord"
# require "ostruct"
# require "date"
# require_all 'app/models'
# require_all 'db/migrate'

# ENV["SINATRA_ENV"] ||= 'development'
# ActiveRecord::Base.establish_connection(ENV["SINATRA_ENV"].to_sym)

require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => "db/development.db"
)

# ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger = nil

require_all 'app'
require_all 'bin'

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'active_record'
require 'pry'
# require_relative './config/environment'

task :environment do
  ENV["ACTIVE_RECORD_ENV"] ||= "development"
  require_relative './config/environment'
end

# include ActiveRecord::Tasks
# DatabaseTasks.db_dir = 'db'
# DatabaseTasks.migrations_paths = 'db/migrate'
# seed_loader = Class.new do
#   def load_seed
#     load "#{ActiveRecord::Tasks::DatabaseTasks.db_dir}/seeds.rb"
#   end
# end
# DatabaseTasks.seed_loader = seed_loader.new
# load 'active_record/railties/databases.rake'

task :console => :environment do
    # binding.pry
    # puts "It didn't work."
  Pry.start
end 
require_relative '../app/models/cone.rb'
require_relative '../app/models/delivery_person.rb'
require_relative '../app/models/ice_cream.rb'
require_relative '../app/models/order.rb'
require_relative '../app/models/user.rb'

require 'bundler'
Bundler.require

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

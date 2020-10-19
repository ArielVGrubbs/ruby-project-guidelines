class Order < ActiveRecord::Base
    has_many :orders
end
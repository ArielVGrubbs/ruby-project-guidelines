class User < ActiveRecord::Base
    has_many :orders
    has_many :ice_creams
end
class User < ActiveRecord::Base
    has_many :orders
    has_many :cones, through: :orders
    has_many :ice_creams, through: :cones
end
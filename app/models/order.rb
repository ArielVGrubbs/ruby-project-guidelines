class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :delivery_person
    has_many :cones
    has_many :ice_creams, through: :cones
end
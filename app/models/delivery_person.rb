class DeliveryPerson < ActiveRecord::Base
    has_many :orders
end
class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :delivery_person
    has_many :ice_creams

    attr_accessor :cones
    
    def initialize
        super
        @cones = []
    end
end
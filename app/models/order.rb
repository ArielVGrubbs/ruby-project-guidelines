class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :delivery_person
    has_many :ice_creams

    attr_accessor :cones

    def cones_create
        @cones ||= []
    end
    
    # def initialize (user_id = nil, delivery_person_id = nil, num_of_cones = 0)
    #     super
    #     @cones = []
    #     @user_id = user_id
    #     @delivery_person_id = delivery_person_id
    #     @num_of_cones = num_of_cones
    #     @num_of_cones += 1
    # end
end
class IceCream < ActiveRecord::Base
    has_many :cones
    has_many :orders, through: :cones
    has_many :users, through: :orders

    @@possible_toppings = ["Sprinkles", "Chocolate Syrup", "Gummy Bears", "Reeses Cup Crumble", "M&Ms", "Caramel Syrup", "Gummy Worms", "Strawberry Syrup"]
    attr_reader :topping

    def in_stock
        print "We do have that flavor in stock!"
    end
    
    def num_of_orders
        self.orders.length
        #come back and make sure this works
    end

    def num_of_users
        self.users.length
        #not sure if this association between ice_creams and users will work, get 2nd opinion
    end

    def possible_toppings
        print "Here are the available toppings:\n"
        @@possible_toppings.each {|topping| print "#{topping}\n"}
        print "\n"
    end

    def topping= (topping_they_chose)
        @topping = topping_they_chose
        print "You've chosen #{topping_they_chose}, and we're certain that'll be delicious with you order!"
    end
end
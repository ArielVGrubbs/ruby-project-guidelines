require_relative '../config/environment'
require 'pry'

class AppCLI
    def self.welcome_user
        prompt = TTY::Prompt.new() 
        puts "Welcome to".colorize(:blue)
        a = Artii::Base.new(:font => 'slant')
        puts a.asciify("Icy Cone!").colorize(:blue) 
        print"\n"
        # print "Welcome to Icy Cone!\n"
        # ice_cream_cone
        order?
        puts "Goodbye!\n".colorize(:blue)
        # if order? == "Exit"
        #     return "Goodbye"
        # end
        #Try setting up an if statement to test the return value
    end

    def self.order?
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Would you like to place an order?", [
            "Yes!",
            "No"
        ])
        
        if user_input == "Yes!"
            sign_in
        end

        if user_input == "No."
            print "Okay, I'll send you out. Have a good day!".colorize(:blue)
            # return "Exit"
        end

        # print "Would you like to place an order?(yes/no)\n"
        # input = gets.chomp
        # if input == "yes"
        #     print "Hit this flag if yes works correctly.\n"
        #     sign_in
        # elsif input == "no"
        #     print "Okay, I'll send you out now.\n"
        #     return "You're finally out!"
        #     #exit the application
        # else
        #     print "Sorry, I didn't understand that, could you try again?\n"
        #     order?
        # end
    end

    def self.sign_in
        print "Please enter your username:\n".colorize(:blue)
        i1 = gets.chomp
        if User.find_by(username: i1) == nil
            user_creation
        end
        if User.find_by(username: i1) != nil
            @user = User.find_by(username: i1)
            order_create
        end
        # if i1 != nil
        #     # puts "We're here!"
        #     @user = User.create(username: i1)
        # else
        #     print "Sorry, I didn't understand that, could you try again?\n"
        #     sign_in
        # end
        # print "Street address you want your order to be delivered to:\n"
        # i2 = gets.chomp
        # @user.address = i2
        # print "Method of payment:\n Visa\n MasterCard\n AmericanExpress\n"
        # i3 = gets.chomp
        # puts "Finished with the sign in"
        # @user.payment_method = i3
        # order_create
        # #don't know how to handle input and put it into argument slots
    end

    def self.user_creation
        prompt = TTY::Prompt.new()
        user_input = prompt.select("I'm sorry, there doesn't appear to be a user by that name, would you like to make an account?", [
            "Yes!",
            "No thanks!"
        ])

        if user_input == "Yes!"
            print "Please enter your a username:\n".colorize(:blue)
            @user = User.create(username: gets.chomp)
            print "Your street address, so we know where to send your delicious goodies!\n".colorize(:blue)
            @user.address = gets.chomp
            prompt2 = TTY::Prompt.new()
            user_input2 = prompt2.select("And finally, your method of payment:", [
                "Visa",
                "MasterCard",
                "American Express",
                "Discover"
            ])
            @user.payment_method = user_input2
            order_create
        end

        if user_input == "No Thanks!"
            print "Okay, well have a good day anyways\n".colorize(:blue)
        end
    end

    def self.order_create
        @order = Order.create(user_id: @user.id)
        @order.delivery_person_id = rand(1..3)
        @order.save
        @order.cones_create
        ordering
    end

    def self.ordering
        print "Here are our flavors: Name | Flavor | Calories | Price\n".colorize(:blue)
        IceCream.all.each {|row| print "#{row.name} | #{row.flavor} | #{row.calories} | #{row.price}\n\n"}
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Which would you like?", [
            "Dirty Pavement",
            "Heaven",
            "Nut",
            "Birth Cream",
            "Muddy Swamp",
            "Icy Vomit"
        ])
        @order.cones << IceCream.find_by(name: user_input)
        prompt2 = TTY::Prompt.new()
        user_input2 = prompt2.select("Would you like to add to your order?", [
            "Yes",
            "No"
        ])
        if user_input2 == "Yes"
            print "\n"
            ordering
        end
        if user_input2 == "No"
            print "\n"
            receipt
        end
        # print "Would you like to add to your order?(yes/no)\n"
        # input = gets.chomp
        # if input == "yes"
        #     ordering
        # end
        # if input == "no"
        #     receipt
        # end
    end

    def self.receipt
        # binding.pry
        names_array = @order.cones.map {|cone| cone.name}
        names = names_array.join(", ")
        total = 0
        @order.cones.each {|cone| total += cone.price}
        print "Here is your order: ".colorize(:blue)
        print "#{names}\n"
        print "And that'll cost a total of: ".colorize(:blue)
        print "$#{total}\n"
        print "Our amazing delivery person, #{@order.delivery_person.name}, will be delivering that soon!\n".colorize(:blue)
        print "Have an Amazing day!\n".colorize(:blue)
        gets.chomp
        #remember to code a randomiser for which delivery person they get assigned and to let them know who it is!
    end

#     def self.ice_cream_cone
#         print "
#           _.-._                    .-._                    .-._                    .-._                    .-._         
#         ,'/ // )                 ,'/ //)                 ,'/ //)                 ,'/ //)                 ,'/ //)         
#        /// // /)               /// // /)               /// // /)               /// // /)               /// // /)        
#       /// // //|              /// // //|              /// // //|              /// // //|              /// // //|        
#      /// // ///              /// // ///              /// // ///              /// // ///              /// // ///         
#     /// // ///              /// // ///              /// // ///              /// // ///              /// // ///          
#    (`: // ///              (`: // ///              (`: // ///              (`: // ///              (`: // ///           
#     `;`: ///                `;`: ///                `;`: ///                `;`: ///                `;`: ///            
#     / /:`:/                 / /:`:/                 / /:`:/                 / /:`:/                 / /:`:/             
#    / /  `'                 / /  `'                 / /  `'                 / /  `'                 / /  `'              
#   / /                     / /                     / /                     / /                     / /                   
#  (_/                     (_/                     (_/                     (_/                     (_/                    \n".colorize(:blue)
#     end
end
# run
AppCLI.welcome_user
# User.destroy_all

#welcome user message
    #gives option for whether or not to order
        #Yes will take you through the path
            #will ask to sign in
                #this next thing will accept username
                #send you to next thing
            #Create an order (automatically)
                #give you a list of ice creams allow you to pick one
                    #picking one will add that cone to your order
                    #gives a list of toppings
                    #Ask if you want more ice cream
                        #if no
                            #Require payment option (maybe)
                            #return receipt
                            #goodbye and thank you for ordering message
                            #send them to the welcome message
                        #if yes
                            #send back to ice cream list
            #
            #create an order
        #no will take you to a confirmation method
            #confirmation method will allow you to either exit the program or go back to welcome message







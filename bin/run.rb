require_relative '../config/environment'
require 'pry'

class AppCLI
    def self.welcome_user
        prompt = TTY::Prompt.new() 
        puts "Welcome to".colorize(:blue)
        a = Artii::Base.new(:font => 'slant')
        puts a.asciify("Icy Cone!").colorize(:blue) 
        print"\n"
        order?
        puts "Goodbye!\n".colorize(:blue)
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
        end
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
            @user.save
            order_create
        end

        if user_input == "No Thanks!"
            print "Okay, well have a good day anyways\n".colorize(:blue)
        end
    end

    def self.order_create
        @order = Order.create(user_id: @user.id)
        @order.delivery_person_id = rand(1..3)
        @order.cones_create
        @order.save
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
            time_window
        end
    end

    def self.time_window
        @current_time_windows = ["6:00-10:00", "10:00-12:00", "12:00-2:00", "2:00-4:00", "4:00-8:00"]
        if Time.now.hour > 10
            @current_time_windows = @current_time_windows.values_at(1, 2, 3, 4)
        end
        if Time.now.hour > 12
            @current_time_windows = @current_time_windows.values_at(2, 3, 4)
        end
        if Time.now.hour > 14
            @current_time_windows = @current_time_windows.values_at(3, 4)
        end
        if Time.now.hour > 16
            @current_time_windows = @current_time_windows.values_at(4)
        end
        if Time.now.hour > 20
            @current_time_windows = "Sorry, we've stopped delivering for the day, you can order tomorrow or come to the store to pick up your order"
            @chosen_time_window = "Sorry, it's too late for us to deliver, so you'll have to come pick up your order."
        end 
        if @current_time_windows != "Sorry, we've stopped delivering for the day, you can order tomorrow or come to the store to pick up your order"
            prompt = TTY::Prompt.new()
            @chosen_time_window = prompt.select("Please select a time you would like your delicious ice cream to be delivered:", [
                @current_time_windows
            ])
        end
        # rewards
        # special_requests?
        choose_driver
    end

    def self.choose_driver
        print "Here are our amazing delivery drivers."
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Take your pick", [
            "Yoel",
            "Sanny",
            "Jordan",
            "Learn more"
        ])
        if user_input == "Yoel"
            print "\n"
            @order.delivery_person = DeliveryPerson.find_by(name: "Yoel")
        end
        if user_input == "Sanny"
            print "\n"
            @order.delivery_person = DeliveryPerson.find_by(name:"Sanny")
        end
        if user_input == "Jordan"
            print "\n"
            @order.delivery_person = DeliveryPerson.find_by(name: "Jordan")
        end
        if user_input == "Learn more"
            print "\n"
            learn_more
        end
        special_requests?
    end
    
    def self.learn_more
        print "Time to learn.\n"
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Who would you like to learn more about?", [
            "Yoel",
            "Sanny",
            "Jordan",
            "Choose driver"        
        ])
        if user_input == "Yoel"
            print "\n"
            yoel
        end
        if user_input == "Sanny"
            print "\n"
            sanny
        end
        if user_input == "Jordan"
            print "\n"
            jordan
        end
        if user_input == "Choose driver"
            print "\n"
            choose_driver
        end
    
    end
    
    def self.yoel
        print "Yoel is amazing"
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Would You like to learn more or choose your driver", [
            "learn more",
            "Choose driver"        
        ])
            
        if user_input == "learn more"
            print "\n"
            learn_more
        end
        if user_input == "Choose driver"
            print "\n"
             choose_driver
        end
    
    end
    
    def self.sanny
        print "Sanny is amazing"
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Would You like to learn more or choose your driver", [
            "learn more",
            "Choose driver"        
        ])
        if user_input == "learn more"
            print "\n"
            learn_more
        end
        if user_input == "Choose driver"
            print "\n"
            choose_driver
        end
    end
    
    def self.jordan
        print "Jordan is amazing"
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Would You like to learn more or choose your driver", [
             "learn more",
            "Choose driver"        
        ])
        if user_input == "learn more"
            print "\n"
            learn_more
        end
        if user_input == "Choose driver"
            print "\n"
            choose_driver
        end
    end

    def self.special_requests?
        prompt = TTY::Prompt.new()
        user_input = prompt.select("Do you have any special requests for your delivery person, #{@order.delivery_person.name}?".colorize(:blue), [
            "Yes",
            "No"
        ])
        if user_input == "Yes"
            special_request
        end
        if user_input == "No"
            rewards
        end
    end

    def self.special_request
        print "Please type in a custom message with your request and it will be given to your delivery person.\n"
        @special_request = gets.chomp
        rewards
    end

    def self.rewards
        rewards = @user.orders.all.size
        if rewards == 3
            @customer_message = "CONGRATULATIONS YOU'RE A GREAT CUSTOMER! And you're entitled to ten percent off your next order!"
        else
            @customer_message = "You've made #{rewards} orders almost enough to be a good customer."
        end
        if rewards == 4
            @customer_message = "Thank you for being such a great customer, as thanks from our team here, you get ten percent off this order."
        end
        total_calculator
    end

    def self.total_calculator
        @total = 0
        @order.cones.each {|cone| @total += cone.price}
        if @customer_message == "Thank you for being such a great customer, as thanks from our team here, you get ten percent off this order."
            @total = @total * 0.9
        end
        receipt
    end

    def self.receipt
        names_array = @order.cones.map {|cone| cone.name}
        names = names_array.join(", ")
        print "Here is your order: ".colorize(:blue)
        print "#{names}\n"
        print "And that'll cost a total of: ".colorize(:blue)
        print "$#{@total}\n"
        if @chosen_time_window != "Sorry, it's too late for us to deliver, so you'll have to come pick up your order."
            print "Our amazing delivery person, #{@order.delivery_person.name}, will be delivering that to #{@user.address}, at around #{@chosen_time_window}.\n".colorize(:blue)
        else
            print "Sorry, it's too late for us to deliver, so you'll have to come pick up your order.".colorize(:blue)
        end
        if @special_request != nil
            print "#{@order.delivery_person.name} will be sure to fufill your special request:".colorize(:blue) + " #{@special_request}\n"
        end
        print "#{@customer_message}\n".colorize(:blue)
        print "Have an Amazing day!\n".colorize(:blue)
        gets.chomp
    end
    
    def self.ice_cream_cone
        print "
                    #######
                 ##         ###
                #            # ##
              ##  ##    /     # ##
             #  ## # #          # #
             # #######          # ##
             ####     #  /      #  ##
             ##      #       /  #  # #
               #   ##          #  # ##
                ###      /    #  # ####
              ###             X  X #####
          ####     /       # /  # ####X####
         #  /          /  #  # # ##X###    ##
         #         X   #   #  #X###       ## #
        # ### X## ## # # ##X#####       # # ###
       # #  # ### ###X### #       /   #  # #####
     ##  /          /         /     #  # #######
     #        /         /        #    # #######
     #  /              #    #     #  ####### #
     #  #   #   #  #  #  #   # ###### # #     ###
     ## ###  ###  # # ### ### # #/        /    # ##
   ##   ### ##### ### ####  #  /             #  # ###
  #              # ## #              /     #   # # ###
  #    /         /            /          #   # # #####
  #         /        /             /   #   #  ## ######
 ##        /                 /    #     #  ## #######
  #   /              /        #     # ### ####### ##
  ##  ##     #   /     # #   #  #### ##### ##### ###
  ###### # #### ## # # # # ####### ##### ######### #
   #  X # #  ##########################   ## #X # #
   #       ###  #         # ##  #          ### #  #
    #       ##      #     # ###     #     # # #  #
    #       ## #          # ##  #         ###  # #
     #X#X / ## X  /X # X / X # X// X # X/  # #X  #
     #X / #X##  /  #X#/ / /# ##  / ##X  / /###   #
      # ### X / X ##X / X## X / X #X# / X# #X# #
       ##X# # X## ### ###X###XX #X# #X# # ###X#
       ###      ###X    ###X#     #X###    ####
       #XX# X ##X ##X # ##### # X####XX X ##X##
        #X###X###X###X###X###X###X###X###X###X 
        # ###XX X X #X#XX X X #X#XX X X#X##X##
        #X   X    ##X# X#    #  #X   ###   X##
        # # X X##X#XX X X #X#XX X X##X# X # ##
        ## # ##X X #   # #### #  #### #X # ###
         #X###X X X X X###XXX X X## X X X ###
         ##X## X # ####X # X X X### X X #X ##
          #### X X#X ### X X X#X#  X # X X#
              ##########################            \n".colorize(:blue)
    welcome_user
    end
end

AppCLI.ice_cream_cone

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
#Original features:
    #Time window thing
    #Award system
    #Allow user the option to pick their delivery person
    #Let the user create a special request that is then added to the receipt at the end, 
    #   maybe even interupting the punctuation of another method if the special request exists

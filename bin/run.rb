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
            time_window
        end
    end

    def self.time_window
        time_windows = ["6:00-10:00", "10:00-12:00", "12:00-2:00", "2:00-4:00", "4:00-8:00"]
        if Time.now.hour > 10
            @current_time_windows = time_windows.values_at(1, 2, 3, 4)
        end
        if Time.now.hour > 12
            @current_time_windows = time_windows.values_at(2, 3, 4)
        end
        if Time.now.hour > 14
            @current_time_windows = time_windows.values_at(3, 4)
        end
        if Time.now.hour > 16
            @current_time_windows = time_windows.values_at(4)
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
        rewards
    end

    def self.rewards
        rewards = @user.orders.all.size
        if rewards > 3
        @customer_message = "CONGRATULATIONS YOU'RE A GREAT CUSTOMER! And you're entitled to half off your next order!"
        else
        @customer_message = "You've made #{rewards} orders almost enough to be a good customer."
        end
        receipt
    end

    def self.receipt
        names_array = @order.cones.map {|cone| cone.name}
        names = names_array.join(", ")
        total = 0
        @order.cones.each {|cone| total += cone.price}
        print "Here is your order: ".colorize(:blue)
        print "#{names}\n"
        print "And that'll cost a total of: ".colorize(:blue)
        print "$#{total}\n"
        if @chosen_time_window != "Sorry, it's too late for us to deliver, so you'll have to come pick up your order."
            print "Our amazing delivery person, #{@order.delivery_person.name}, will be delivering that around #{@chosen_time_window}.\n".colorize(:blue)
        else
            print "Sorry, it's too late for us to deliver, so you'll have to come pick up your order.".colorize(:blue)
        end
        print "#{@customer_message}\n".colorize(:blue)
        print "Have an Amazing day!\n".colorize(:blue)
        gets.chomp
    end

    def self.ice_cream_cone
        print "
                      ###
                 ## # # # # ###
                #            # ##
              ##  ##    /     # ##
             #  ## # #          # #
             # #######          # ##
             ####     #  /      # # #
             ##      #       /  # # ##
               #   ##          # #  ##
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
       #X###X###X###X###X###X###X###X#######X##
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
          X # X X#### X # X X ###XX X X # X##
           X X #X#X X ## X XX#X# X X # ### #
          ##X###X X X X ###X# X X X ##X X X#
          ###### # X X## X X X # ##X X X X #
          # X X X ###X# X X X X##X# X X X###
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
    #
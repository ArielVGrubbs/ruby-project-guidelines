require_relative '../config/environment'
require 'pry'

class AppCLI
    def self.welcome_user
        #This method prints out a stylized welcome message for the user to see at the beginning of a session.
        prompt = TTY::Prompt.new() 
        puts "Welcome to".colorize(:blue)
        a = Artii::Base.new(:font => 'slant')
        puts a.asciify("Icy Cone!").colorize(:blue) 
        print"\n"
        order?
        puts "Goodbye!\n".colorize(:blue)
    end

    def self.order?
        #This method asks if you would like to place an order then directs you according to your response.
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
        #This method checks to see if the username you enter is associated with an existing row in the users table as well as an existing user instance.
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
        #This method follows after the previous method determines that there is no user with the username you entered and then asks you 
        #to create a new user instance and row if there is not one currently in place. There is no way to proceed through the rest of the 
        #program if you don't have a user instance as many of the later methods use the features and relationships of the current instance 
        #of the user class to function. It then asks you to enter some data about yourself into your row in the users table so that the 
        #later methods can use that information to make it feel more user driven and less like we're railroading them.
        prompt = TTY::Prompt.new()
        user_input = prompt.select("I'm sorry, there doesn't appear to be a user by that name, would you like to make an account?", [
            "Yes!",
            "No thanks!"
        ])

        if user_input == "No Thanks!"
            print "Okay, well have a good day anyways\n".colorize(:blue)
            #Once again, we don't let the user continue if they aren't associated to an existing user.
        end

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
            # order_create
        end
    end

    def self.order_create
        #This method shouldn't ever be seen by the user, it just does some behind the scenes clerical work: creating an order instance, activating a helper method in the Order class,
        #and saving the changes before forwarding the user along.
        @order = Order.create(user_id: @user.id)
        @order.cones_create
        @order.save
        ordering
    end

    def self.ordering
        #This method shows the user the menu, and allows them to pick one off of the menu as many times as they want before they move on.
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
        #This method checks the current time against a premade list of time windows, and if it's later than any of the time windows it takes those windows out of the array of available time
        #windows and then presents that array to the user in the form of a multiple choice prompt. This has glitched before and refused to show any of the time windows when they should have 
        #been shown, so I set the instance variable equal to the full array before all of the IF statements, so if the IF statement logic bugs out again it'll just display all of the possible
        #times.
        @current_time_windows = ["6:00-10:00", "10:00-12:00", "12:00-2:00", "2:00-4:00", "4:00-8:00"]
        # if Time.now.hour > 10
        #     @current_time_windows = @current_time_windows.values_at(1, 2, 3, 4)
        # end
        # if Time.now.hour > 12
        #     @current_time_windows = @current_time_windows.values_at(2, 3, 4)
        # end
        # if Time.now.hour > 14
        #     @current_time_windows = @current_time_windows.values_at(3, 4)
        # end
        # if Time.now.hour > 16
        #     @current_time_windows = @current_time_windows.values_at(4)
        # end
        # if Time.now.hour > 20
        #     @current_time_windows = "Sorry, we've stopped delivering for the day, you can order tomorrow or come to the store to pick up your order"
        #     @chosen_time_window = "Sorry, it's too late for us to deliver, so you'll have to come pick up your order."
        # end 
        if @current_time_windows != "Sorry, we've stopped delivering for the day, you can order tomorrow or come to the store to pick up your order"
            prompt = TTY::Prompt.new()
            @chosen_time_window = prompt.select("Please select a time you would like your delicious ice cream to be delivered:", [
                @current_time_windows
            ])
        end
        choose_driver
    end

    def self.choose_driver
        #This method allows you to pick your delivery driver, or go down a rabbit hole of learning a little bit more about them, before returning here to pick one anyways. Picking one will
        #result in the establishment of a "belongs_to" ActiveRecord relationship between the user's order instance and the chosen driver.
        print "Here are our amazing delivery drivers.\n"
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
        @order.save
        special_requests?
    end
    
    def self.learn_more
        #This method acts as the central hub of this rabbit hole, and directs the user to pick one of the drivers to learn more about.
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
        #None of these methods actually have any fun facts about the driver's, since we are using the names of our cohort mates, and we didn't want to either make assumptions or
        #ask them for their life story while they're also busy building their own Phase 1 Projects. So the fun fact for each of them is that they're amazing.
        print "Yoel is amazing\n"
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
        #This method is the same as the one for Yoel, but with the name changed, and ultimately referencing a different pre-established delivery person instance.
        print "Sanny is amazing\n"
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
        #This method is the same as the one for Yoel, but with the name changed, and ultimately referencing a different pre-established delivery person instance.
        print "Jordan is amazing\n"
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
        #This method asks the user if they want to write a special request into the instructions for the delivery person.
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
        #This method allows the user to write a custom little string that will display at the end and was inspired by the special request option when ordering pizza through an app.
        #I'm not certain, but upon thinking about it this is probably the users best chance to break the code by writing a too big string.
        print "Please type in a custom message with your request and it will be given to your delivery person.\n".colorize(:blue)
        @special_request = gets.chomp
        rewards
    end

    def self.rewards
        #This method checks the user instance's orders to see how many times they've ordered, and if it's at a certain amount it will reward them for being loyal customers,
        #in a real life application, if this existed at all, it would be much less frequent and would reset once the user has claimed their discount, but in this version we
        #just set it to proc once when they order 4 times, and to let them know it's about to happen on their 3rd order.
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
        #This method calculates the total of the user's order. It takes the possible existence of the rewards bargain into account. Before the rewards method this calculation was just done
        #inside the receipt method, but with the additional complication of needing to sometimes calculate the reward, it just seemed to not belong inside the receipt function anymore.
        #According to Ruby best practices no method should do more than one thing, but I didn't foolw that rule very well in this project.
        @total = 0
        @order.cones.each {|cone| @total += cone.price}
        if @customer_message == "Thank you for being such a great customer, as thanks from our team here, you get ten percent off this order."
            @total = @total * 0.9
        end
        receipt
    end

    def self.receipt
        #This method is where the user's path comes to an end and all the results of the choices they've made are displayed.
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
        #This method prints ascii art of a frozen yogurt at the beginning of the users experience. It does jazz up the aesthetic a little bit, but I mainly put this in because I had free time.
        print "
                    #######
                 ##         ###
                #            # ##
              ##  ##    /     # ##
             #  ## # #          # #
             # #######          # ##
             ####     #  /      #/ ##
             ##      #       / # / # #
               #   ##         X   # ##
                ###      /   # / # ####
              ###          X   # X #####
          ####     /     #   X  #X####X ###
         #         X   X   #  #X###       ## #
        # ### X## ## # # ##X#####       # # ###
       # #  # ### ###X### #       /   #  # #####
     ##  /          /         /     #  # #######
     #        /         /        #    # #######
     #  /              #    #     #  ####### #
     #  #   #   #  #  #  #   # ###### # #     ###
     ## ###  ###  # # ### ### # #/        /    # ##
   ##   ### ##### ### ####  #  /             #  # ###
  #              / ## #              /     #   # # ###
  #    /         /            /      /   #   # # #####
 ##        /                 /    # / # #  ## #######
  #   /              /        #  X  # ### ####### ##
  ##  ##     #   /     # #   #  #### ##### ##### ###
  ###### # #### ## # # # # ##Hugo# ##### ######### #
   #  X # #  ##################Delgado##   ## #X # #
   #       ###  #         # ##  #          ### #  #
    #       ##      #     # ###     #     # # #  #
    #       ## #          # ##  #         ###  # #
     #X / #X##  /  #X#/ / /# ##  / ##X  / /###   #
      # ### X / X ##X / X## X / X #X# / X# #X# #
       ##X# # X## ### ###X###XX #X# #X# # ###X#
       ###      ###X    ###X#     #X###    ####
        #X###X###X###X###X###X###X###X###X###X 
        #X   X    ##X# X#    #  #X   ###   X##
        # # X X##X#XX X X #X#XX X X##X# X # ##
        ## # ##X X #   # #### #  #### #X # ###
         #X###X Ariel X###XXX X X # Grubbs ##
         ##X## X # ####X # X X X### X X #X ##
          #### X X#X ### X X X#X#  X # X X#
              ##########################            \n".colorize(:blue)
    welcome_user
    end
end

AppCLI.ice_cream_cone
#This line of code calls the first method inside the AppCLI class and starts the whole thing.
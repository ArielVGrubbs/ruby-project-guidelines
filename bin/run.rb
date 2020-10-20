require_relative '../config/environment'

class AppCLI
    def self.welcome_user
        print "Welcome to Icy Cone!\n"
        order?
    end

    def self.order?
        print "Would you like to place an order?(yes/no)\n"
        input = gets.chomp
        if input == "yes"
            sign_in
        elsif input == "no"
            print "Okay, I'll send you out now.\n"
            #exit the application
        else
            print "Sorry, I didn't understand that, could you try again?\n"
            order?
        end
    end

    def self.sign_in
        print "Please enter your username:\n"
        i1 = gets.chomp
        if i1 != nil
            puts "We're here!"
            @user = User.create(username: i1)
        else
            print "Sorry, I didn't understand that, could you try again?\n"
            sign_in
        end
        print "Street address you want your order to be delivered to:\n"
        i2 = gets.chomp
        @user.address = i2
        print "Method of payment:\n Visa\n MasterCard\n AmericanExpress\n"
        i3 = gets.chomp
        puts "Finished with the sign in"
        @user.payment_method = i3
        order_create
        # #don't know how to handle input and put it into argument slots
    end

    def self.order_create
        #put in all the ice creams that we have, with a row from the ice_creams table for each with their flavors, calories, and price
        @order = Order.new(user_id: @user.id)
        ordering
    end

    def ordering
        print "Here are all our flavors:\n"
        IceCream.all.each {|row| print "#{row.name} | #{row.flavor} | #{row.calories} | #{row.price}\n"}
        print "Which would you like?\n"
        @order.cones << IceCream.find_by(name: gets.chomp)
        print "Would you like to add to your order?(yes/no)"
        input = gets.chomp
        if input == "yes"
            ordering
        else
            receipt
        end
    end

    def receipt
        print "Here is your order:\n #{@order.cones}\n Have an Amazing day!"
    end

    # def exit_user
    #     # print "Goodbye #{@user}, and thank you for shopping with (Placeholder name)!"
    # end
  
    # def self.run
    #     # user = User.create


    #     welcome_user
    #     # order?
    #     # sign_in

    #     # receipt
    #     # exit_user
    # end
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







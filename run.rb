class AppCLI
    def self.welcome_user
        print "Welcome to Lactose Intolerant Suicide!"
        # obviously we should change the name, maybe do some aski art like the Bake My Day example
    end

    def order?
        # print "Would you like to place an order?(y/n)\n"
        # gets.chomp
        # if gets.chomp == y

        #     ordering
        # elsif gets.chomp == n
        #     exit_user
        #     #exit the application
        # else
        #     print "I'm sorry, I don't quite understand, could you try that again?"
        #     order?
        # end
    end

    def sign_in
        # print "Please enter your username:\n"
        # gets.chomp
        # @user = User.find_by(username: value)
        # print "Street address you want your order to be delivered to:\n"

        # print "Method of payment:\n Visa\n MasterCard\n AmericanExpress\n"
        # USER.method_of_payment = gets.chomp
        # #don't know how to handle input and put it into argument slots
    end

    def ordering
        #put in all the ice creams that we have, with a row from the ice_creams table for each with their flavors, calories, and price
        # @user_order = []
        # ice_creams.map do |ice_cream|
        #     puts "#{ice_cream.name}\n"
        #     puts "#whole row"
        # end
        # @user_order << gets.chomp
        # print "Thank you for ordering! Your #{gets.chomp} will arrive at your door soon!"
    end

    def receipt
        # print "Here is your order:\n #{Ice_Cream.find_by(name: @user_order)}"
    end

    def exit_user
        # print "Goodbye #{@user}, and thank you for shopping with (Placeholder name)!"
    end
  
    def self.run
        # user = User.create


        # welcome_user
        # order?
        # sign_in
        # receipt
        # exit_user
    end
end

AppCLI.run

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







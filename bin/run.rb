require_relative '../config/environment'
require 'pry'
require 'rest-client'
require 'json'
# require_relative './config/environment.rb'

class AppCLI

    def self.welcome_user
        print "Welcome to Lactose Intolerant Suicide!"
        #obviously we should change the name, maybe do some aski art like the Bake My Day example
    end

    def sign_in
        print "Please enter your username:\n"
        gets.chomp
        @user = User.find_by(username: value)
        print "Street address you want your order to be delivered to:\n"

        print "Method of payment:\n Visa\n MasterCard\n AmericanExpress\n"
        USER.method_of_payment = gets.chomp
        #don't know how to handle input and put it into argument slots
    end

    def order?
        print "Would you like to place an order?(y/n)\n"
        gets.chomp
        if gets.chomp == y

            ordering
        elsif gets.chomp == n
            exit_user
            #exit the application
        else
            print "I'm sorry, I don't quite understand, could you try that again?"
            order?
        end
    end

    def ordering
        #put in all the ice creams that we have, with a row from the ice_creams table for each with their flavors, calories, and price
        @user_order = []
        ice_creams.map do |ice_cream|
            puts "#{ice_cream.name}\n"
            puts "#whole row"
        end
        @user_order << gets.chomp
        print "Thank you for ordering! Your #{gets.chomp} will arrive at your door soon!"
    end

    def receipt
        print "Here is your order:\n #{Ice_Cream.find_by(name: @user_order)}"
    end

    def exit_user
        print "Goodbye #{@user}, and thank you for shopping with (Placeholder name)!"
    end

    #   def ask_for_input
    #     puts "Search for books related to:"
    #     gets.chomp
    #   end
    
    #   def look_for_books(search_term)
    #     url = "https://www.googleapis.com/books/v1/volumes?q=#{search_term}"
    #     response = RestClient.get(url)
    #     parsed_json = JSON.parse(response)
    #     parsed_json["items"]
    #   end
    
    #   def print_titles(books)
    #     books.each_with_index do |book,index|
    #       # puts "#{index+1}: #{book["volumeInfo"]["title"]} by #{book["volumeInfo"]["authors"][0]} "
    #       author = Author.create(username: book["volumeInfo"]["authors"][0])
    #       Book.create(title: book["volumeInfo"]["title"], author_id: author.id )
    #     end
    #   end
  
    def self.run
        user = User.create


        welcome_user
        sign_in
        order?
        receipt
        exit_user
    end
end

  
AppCLI.run


puts "HELLO WORLD"

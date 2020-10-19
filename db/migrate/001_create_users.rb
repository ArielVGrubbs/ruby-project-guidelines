class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :username
            t.string :method_of_payment
        end
    end
end
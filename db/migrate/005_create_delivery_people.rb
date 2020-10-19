class CreateDeliveryPeople < ActiveRecord::Migration
    def change
        create_table :delivery_people do |t|
            t.string :name
        end
    end
end
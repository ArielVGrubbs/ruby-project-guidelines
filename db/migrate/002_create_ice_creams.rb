class CreateIceCreams < ActiveRecord::Migration
    def change
        create_table :ice_creams do |t|
            t.string :name
            t.string :flavor
            t.string :calories
            t.string :price
        end
    end
end
class CreateCones < ActiveRecord::Migration[6.0]
  def change
    create_table :cones do |t|
      t.integer :order_id
      t.integer :ice_cream_id
      t.string :toppings
    end
  end
end

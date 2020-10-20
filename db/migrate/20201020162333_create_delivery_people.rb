class CreateDeliveryPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_people do |t|
      t.string :name
    end
  end
end

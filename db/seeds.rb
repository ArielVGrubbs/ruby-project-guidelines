User.destroy_all
IceCream.destroy_all




# vanilla = IceCream.create(name: "Cow Liquid", flavor: "vanilla", calories: 137, price: 5.00)
# chocolate = IceCream.create(name: "Dirty Cow Liquid", flavor: "chocolate", calories: 137, price: 5.00)
rock_road = IceCream.create(name: "Dirty Pavement", flavor: "Rocky Road", calories: 170, price: 6.00 )
mint_chocolate = IceCream.create(name: "Heaven", flavor: "Mint Chocolate", calories: 300, price: 7.00)
peanut_pecan = IceCream.create(name: "Nut", flavor: "Peanut Pecan", calories: 134, price: 6.00)
birthday_cake = IceCream.create(name: "Birth Cream", flavor: "Birthday Cake", calories: 140, price: 5.00)
# strawberry = IceCream.create(name: "Bloody Massacre", flavor: "Strawberry Shortcake", calories: 137, price: 6.00)
chocolate_deluxe = IceCream.create(name: "Muddy Swamp", flavor: "Chocolate Deluxe", calories: 177, price: 5.00)
green_tea = IceCream.create(name: "Icy Vomit", flavor: "Green Tea", calories: 14, price: 6.00)



dp1 = DeliveryPerson.create(name: "Yoel")
dp2 = DeliveryPerson.create(name: "Sanny")
dp3 = DeliveryPerson.create(name: "Jordan")

# orders = Orders.create()







# create_table :orders do |t|
#     t.integer :user_id
#     t.integer :delivery_person_id
#     t.integer :num_of_cones
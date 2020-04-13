# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.destroy_all
Contact.destroy_all
User.destroy_all

user_ids = []

user_ids << User.create(name: "John Doe", email: "johndoe@test.com", password: "secret").id
user_ids << User.create(name: "Jane Roe", email: "janeroe@test.com", password: "secret").id

groups_ids = {user_ids[0] => [], user_ids[1] => []}
p "two users created"

groups_ids[user_ids[0]] << Group.create(name: "Clients", user_id: user_ids[0]).id
groups_ids[user_ids[0]] << Group.create(name: "Friends", user_id: user_ids[0]).id
groups_ids[user_ids[1]] << Group.create(name: "TheFam", user_id: user_ids[1]).id
groups_ids[user_ids[1]] << Group.create(name: "Midnight Hours", user_id: user_ids[1]).id

p "#{groups_ids.count} groups created"

groups_count = groups_ids.length

nb_of_contacts = 60

contacts = []

nb_of_contacts.times do |i|
    user_id = user_ids[Random.rand(0...2)]
    new_contact = {
        name: Faker::Name.name,
        company: Faker::Company.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        address: "#{Faker::Address.street_address} #{Faker::Address.zip} #{Faker::Address.city}",
        group_id: groups_ids[user_id][Random.rand(0...groups_count)],
        user_id: user_id
    }
    contacts.push(new_contact)
end

Contact.create(contacts)

p "#{nb_of_contacts} contacts created"
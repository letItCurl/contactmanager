# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.destroy_all
Contact.destroy_all

groups_ids = []

groups_ids << Group.create(name: "Clients").id
groups_ids << Group.create(name: "Friends").id
groups_ids << Group.create(name: "TheFam").id
groups_ids << Group.create(name: "Midnight Hours").id

p "#{groups_ids.count} groups created"

groups_count = groups_ids.length

nb_of_contacts = 20

contacts = []

nb_of_contacts.times do |i|
    new_contact = {
        name: Faker::Name.name,
        company: Faker::Company.name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        address: "#{Faker::Address.street_address} #{Faker::Address.zip} #{Faker::Address.city}",
        group_id: groups_ids[Random.rand(0...groups_count)]
    }
    contacts.push(new_contact)
end

Contact.create(contacts)

p "#{nb_of_contacts} contacts created"
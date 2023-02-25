# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!({ name: 'Samuel Cox', email: 'samc1253@gmail.com', google_id: '110920554030325122207' })


business = user.shelves.find_by_name('Business')
friend = user.shelves.find_by_name('Friends')
family = user.shelves.find_by_name('Family')

family.ferns.create!({ name: 'Erin', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
family.ferns.create!({ name: 'Brian', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
friend.ferns.create!({ name: 'Austin', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
friend.ferns.create!({ name: 'Kieffer', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
friend.ferns.create!({ name: 'Roshan', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
friend.ferns.create!({ name: 'Nate', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
business.ferns.create!({ name: 'Anthony', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
business.ferns.create!({ name: 'Drew', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
business.ferns.create!({ name: 'Brady', preferred_contact_method: ['text', 'phone', 'email'].sample, health: Faker::Number.between(from: 1, to: 10) })
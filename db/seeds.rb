# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!({ name: 'Samuel Cox', email: 'samc1253@gmail.com', google_id: '110920554030325122207' })


business = user.shelves.create!({ name: 'Business' })
friend = user.shelves.create!({ name: 'Friend' })
family = user.shelves.create!({ name: 'Family' })

family.ferns.create!({ name: 'Erin', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
family.ferns.create!({ name: 'Brian', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
family.ferns.create!({ name: 'Austin', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
friend.ferns.create!({ name: 'Kieffer', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
friend.ferns.create!({ name: 'Roshan', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
friend.ferns.create!({ name: 'Nate', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
business.ferns.create!({ name: 'Anthony', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
business.ferns.create!({ name: 'Drew', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
business.ferns.create!({ name: 'Brady', frequency: Faker::Number.between(from: 1, to: 10), preferred_contact_method: ['text', 'phone', 'email'].sample })
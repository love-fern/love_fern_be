user = User.create!({ name: 'Samuel Cox', email: 'samc1253@gmail.com', google_id: '110920554030325122207' })
user_2 = User.create!({ name: 'Drew Layton', email: 'dlayton66@gmail.com', google_id: '158928345209680286502' })

business = user.shelves.find_by_name('Business')
friend = user.shelves.find_by_name('Friends')
family = user.shelves.find_by_name('Family')

family.ferns.create!({ name: 'Erin', preferred_contact_method: 'text', health: 1 })
family.ferns.create!({ name: 'Brian', preferred_contact_method: 'phone', health: 2 })
friend.ferns.create!({ name: 'Austin', preferred_contact_method: 'email', health: 3 })
friend.ferns.create!({ name: 'Kieffer', preferred_contact_method: 'text', health: 1 })
friend.ferns.create!({ name: 'Roshan', preferred_contact_method: 'phone', health: 5 })
friend.ferns.create!({ name: 'Nate', preferred_contact_method: 'email', health: 6 })
business.ferns.create!({ name: 'Anthony', preferred_contact_method: 'text', health: 7 })
business.ferns.create!({ name: 'Drew', preferred_contact_method: 'phone', health: 8 })
brady = business.ferns.create!({ name: 'Brady', preferred_contact_method: 'email', health: 9 })

brady.interactions.create!({ evaluation: 'Positive', description: 'message' })
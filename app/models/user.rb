class User < ApplicationRecord
  has_many :shelves
  has_many :ferns, through: :shelves

  def default_shelves
    self.shelves.create(name: "Friends")
    self.shelves.create(name: "Family")
    self.shelves.create(name: "Romantic")
    self.shelves.create(name: "Business")
  end
end
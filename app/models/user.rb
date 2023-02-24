class User < ApplicationRecord
  after_create :default_shelves

  has_many :shelves, dependent: :destroy
  has_many :ferns, through: :shelves

  private
    def default_shelves
      shelves.create(name: "Friends")
      shelves.create(name: "Family")
      shelves.create(name: "Romantic")
      shelves.create(name: "Business")
    end
end
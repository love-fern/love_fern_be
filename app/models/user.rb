class User < ApplicationRecord
  has_many :shelves
  has_many :ferns, through: :shelves
end
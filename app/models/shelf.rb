class Shelf < ApplicationRecord
  belongs_to :user
  has_many :ferns

  validates_presence_of :name, :user_id
end
class Interaction < ApplicationRecord
  belongs_to :fern
  validates :description, presence: true
end

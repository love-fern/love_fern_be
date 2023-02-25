class Interaction < ApplicationRecord
  belongs_to :fern
  validates_presence_of :evaluation


end
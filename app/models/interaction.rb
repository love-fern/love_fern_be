class Interaction < ApplicationRecord
  belongs_to :fern
  validates :evaluation, 
    presence: true, 
    inclusion: { in: ['Positive', 'Negative', 'Neutral'] }
end
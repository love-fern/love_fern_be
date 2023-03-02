class Interaction < ApplicationRecord
  belongs_to :fern
  validates :evaluation,
            presence: true,
            inclusion: { in: %w[Positive Negative Neutral] }
  validates :description, presence: true
end

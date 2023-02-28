class Fern < ApplicationRecord
  belongs_to :shelf
  has_one :user, through: :shelf
  has_many :interactions, dependent: :destroy

  validates_presence_of :name, :health, :preferred_contact_method, :shelf_id

  THRESHOLD = 0

  def message_update(rating)
    if rating > THRESHOLD
      self.health += 1 if self.health < 10
      self.interactions.create(evaluation: "Positive")
    elsif rating < THRESHOLD*(-1)
      self.health -= 1 if self.health > 0
      self.interactions.create(evaluation: "Negative")
    else
      self.interactions.create(evaluation: "Neutral")
    end
  end
end
class Fern < ApplicationRecord
  belongs_to :shelf
  has_one :user, through: :shelf
  has_many :interactions

  validates_presence_of :name, :health, :preferred_contact_method, :shelf_id

  def message_update(rating)
    if rating > 0
      self.health += 1 if self.health < 10
      self.interactions.create(evaluation: "Positive")
    elsif rating < 0 
      self.health -= 1 if self.health > 0
      self.interactions.create(evaluation: "Negative")
    end
  end
end
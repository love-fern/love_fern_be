class Fern < ApplicationRecord
  belongs_to :shelf
  has_one :user, through: :shelf
  has_many :interactions, dependent: :destroy

  validates_presence_of :name, :health, :preferred_contact_method, :shelf_id

  THRESHOLD = 0

  def message_update(rating)
    if rating > THRESHOLD
      self.health += 2 if health < 10
      interactions.create(evaluation: 'Positive')
    elsif rating < THRESHOLD * -1
      self.health -= 2 if self.health > 0
      interactions.create(evaluation: 'Negative')
    else
      interactions.create(evaluation: 'Neutral')
    end
    health_limits
  end

  private

  def health_limits
    self.health = 10 if self.health > 10
    self.health = 0 if self.health < 0
  end
end

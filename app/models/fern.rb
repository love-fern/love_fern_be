class Fern < ApplicationRecord
  belongs_to :shelf

  validates_presence_of :name, :health, :preferred_contact_method, :shelf_id

  def message_update(rating)
    if rating > 0
      self.health += 1 if self.health < 10
    elsif rating < 0 
      self.health -= 1 if self.health > 0
    end
  end
end
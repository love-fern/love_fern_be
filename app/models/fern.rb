class Fern < ApplicationRecord
  has_paper_trail only: :health
  
  belongs_to :shelf
  has_one :user, through: :shelf
  has_many :interactions, dependent: :destroy

  validates_presence_of :name, :health, :preferred_contact_method, :shelf_id

  before_update :health_limits

  NEUTRAL_THRESHOLD = 0.25 # health is unaffected within threshold
  HEALTH_MESSAGE_RATIO = 3

  def message_update(rating)
    interactions.create(evaluation: rating, description: 'message')

    unless rating.between?(NEUTRAL_THRESHOLD*-1, NEUTRAL_THRESHOLD)
      self.update(health: health + rating*HEALTH_MESSAGE_RATIO)
    end
  end

  def activity_update(activity)
    interactions.create(description: activity)
    self.update(health: health + 4)
  end

  def health_history
    versions.where(event: "update").map { |fern| fern.changeset["health"][0] } << versions.last.changeset["health"][1]
  end

  private

  def health_limits
    self.health = 10 if self.health > 10
    self.health = 0 if self.health < 0
  end
end

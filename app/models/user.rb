class User < ApplicationRecord
  after_create :default_shelves

  has_many :shelves, dependent: :destroy
  has_many :ferns, through: :shelves

  validates_presence_of :name, :email, :google_id

  private

  def default_shelves
    shelves.create(name: 'Friends')
    shelves.create(name: 'Family')
    shelves.create(name: 'Romantic')
    shelves.create(name: 'Business')
  end
end

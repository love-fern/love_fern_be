require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:ferns) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :google_id }
  end

  describe 'callbacks' do
    it 'generates default shelves after user creation' do
      user = create(:user)
      expect(user.shelves.pluck(:name).sort).to eq(%w[Business Family Friends Romantic])
    end

    it 'deletes shelves upon user deletion' do
      user = create(:user)

      expect(Shelf.count).to eq(4)

      user.destroy

      expect(Shelf.count).to eq(0)
    end
  end
end

require 'rails_helper'

RSpec.describe Shelf do
  describe 'relationships' do
    it { should have_many(:ferns) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
  end
end

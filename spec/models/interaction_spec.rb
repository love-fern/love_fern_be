require 'rails_helper'

RSpec.describe Interaction do
  describe 'relationships' do
    it { should belong_to(:fern)}
  end

  describe 'validations' do
    it { should validate_presence_of(:evaluation) }
    it { should validate_inclusion_of(:evaluation).in_array(['Positive', 'Negative', 'Neutral']) }
  end
end
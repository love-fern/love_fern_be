require 'rails_helper'

RSpec.describe Fern do
  let(:fern) { create(:fern) }
  let(:upper_threshold) { Fern::THRESHOLD }
  let(:lower_threshold) { Fern::THRESHOLD * -1}

  describe "relationships" do
    it { should belong_to(:shelf) }
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :health}
    it {should validate_presence_of :preferred_contact_method}
    it {should validate_presence_of :shelf_id}
  end

  it 'should have a default health of 7' do
    expect(fern.health).to eq(7)
  end

  describe '#message_update' do
    context 'receives rating from google sentiment api' do
      context 'fern health' do
        it 'increases if rating is above threshold' do
          fern.message_update(upper_threshold+0.1)

          expect(fern.health).to eq(8)
        end

        it 'decreases if rating is below threshold' do
          fern.message_update(lower_threshold-0.1)

          expect(fern.health).to eq(6)
        end

        it 'does not change if within or equal to threshold' do
          fern.message_update(lower_threshold)

          expect(fern.health).to eq(7)

          fern.message_update(upper_threshold)

          expect(fern.health).to eq(7)

          fern.message_update(0)

          expect(fern.health).to eq(7)
        end

        it 'will not go below 0' do
          fern.health = 1
          fern.message_update(lower_threshold-0.1)

          expect(fern.health).to eq(0)

          fern.message_update(lower_threshold-34)

          expect(fern.health).to eq(0)
        end

        it 'will not go above 10' do
          fern.health = 9
          fern.message_update(upper_threshold+0.1)

          expect(fern.health).to eq(10)

          fern.message_update(upper_threshold+34)
          
          expect(fern.health).to eq(10)
        end
      end

      context 'interaction creation' do
        it 'creates a positive interaction entry' do
          fern.message_update(upper_threshold+0.1)
          expect(Interaction.last.evaluation).to eq("Positive")
        end

        it 'creates a negative interaction entry' do
          fern.message_update(upper_threshold-0.1)
          expect(Interaction.last.evaluation).to eq("Negative")
        end

        it 'creates a neutral interaction entry' do
          fern.message_update(0)
          expect(Interaction.last.evaluation).to eq("Neutral")
        end
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Fern do
  let(:fern) { create(:fern) }
  let(:upper_threshold) { Fern::NEUTRAL_THRESHOLD }
  let(:lower_threshold) { Fern::NEUTRAL_THRESHOLD * -1 }

  describe 'relationships' do
    it { should belong_to(:shelf) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :health }
    it { should validate_presence_of :preferred_contact_method }
    it { should validate_presence_of :shelf_id }
  end

  it 'should have a default health of 7' do
    expect(fern.health).to eq(7)
  end

  describe '#message_update' do
    context 'receives rating from google sentiment api' do
      context 'fern health' do
        it 'increases for positive rating' do
          rating = 0.7
          expected_health_change = rating*Fern::HEALTH_MESSAGE_RATIO

          expect { 
            fern.message_update(rating) 
          }.to change(fern, :health).by(expected_health_change)
        end

        it 'decreases for negative rating' do
          rating = -0.7
          expected_health_change = rating*Fern::HEALTH_MESSAGE_RATIO

          expect { 
            fern.message_update(rating) 
          }.to change(fern, :health).by(expected_health_change)
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
          fern.message_update(-1)

          expect(fern.health).to eq(0)

          fern.message_update(-99)

          expect(fern.health).to eq(0)
        end

        it 'will not go above 10' do
          fern.health = 9
          fern.message_update(1)

          expect(fern.health).to eq(10)

          fern.message_update(99)

          expect(fern.health).to eq(10)
        end
      end

      context 'interaction creation' do
        it 'stores the sentiment analysis rating' do
          fern.message_update(0.75)
          expect(Interaction.last.evaluation).to eq(0.75)
          fern.message_update(-0.75)
          expect(Interaction.last.evaluation).to eq(-0.75)
          fern.message_update(0)
          expect(Interaction.last.evaluation).to eq(0)
        end
      end
    end
  end

  describe '#activity_update' do
    context 'did activity with person' do
      it 'increases health by 4' do
        fern.health = 0
        fern.activity_update('Play a game of tennis with a friend')

        expect(fern.health).to eq(4)
      end

      it 'stores the activity' do
        fern.activity_update("Solve a Rubik's cube")
        last_activity = fern.interactions.last

        expect(last_activity.description).to eq("Solve a Rubik's cube")
        expect(last_activity.evaluation).to be_within(0.01).of(4/3)
      end
    end
  end
end

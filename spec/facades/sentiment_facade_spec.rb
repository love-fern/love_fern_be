require 'rails_helper'

RSpec.describe "sentiment facade" do
  it 'can get the sentiment rating from the google service', :vcr do
    message = "Hello. I am a muffin. Eat me."
    expect(SentimentFacade.message_rating(message)).to eq(-0.1)
  end


end
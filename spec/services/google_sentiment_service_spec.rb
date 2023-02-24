require 'rails_helper'

RSpec.describe "google sentiment service", :vcr do
  it 'returns a response analyzing an input text' do
    query = "Hello. I am a muffin. Eat me."
              
    sentiment_response = GoogleSentimentService.get_sentiment(query)
    expect(sentiment_response).to eq({
                        documentSentiment: {
                          magnitude: 0.5,
                          score: -0.1
                        },
                        language: "en",
                        sentences: [
                          {
                            text: {
                              content: "Hello.",
                              beginOffset: 0
                            },
                            sentiment: {
                              magnitude: 0.1,
                              score: 0.1
                            }
                          },
                          {
                            text: {
                              content: "I am a muffin.",
                              beginOffset: 7
                            },
                            sentiment: {
                              magnitude: 0.3,
                              score: -0.3
                            }
                          },
                          {
                            text: {
                              content: "Eat me.",
                              beginOffset: 22
                            },
                            sentiment: {
                              magnitude: 0.1,
                              score: -0.1
                            }
                          }
                        ]
                      })
  end


end
class SentimentFacade
  def self.message_rating(message)
    response = GoogleSentimentService.get_sentiment(message)[:documentSentiment][:score]
  end
end

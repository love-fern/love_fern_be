class SentimentFacade
  def self.message_rating(message)
   
    GoogleSentimentService.get_sentiment(message)[:documentSentiment][:score]
  end
end
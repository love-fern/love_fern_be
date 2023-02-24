class GoogleSentimentService
  def self.get_sentiment(message)
    # binding.pry
    request = conn.post do |req|
      req.body = google_query_format(message)
    end
    JSON.parse(request.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(
      url: "https://language.googleapis.com/v1/documents:analyzeSentiment",
      params: {key: ENV['GOOGLE_API_KEY'] }
    )
  end

  def google_query_format(input)
    {
      document: {
        content: input,
        language: "",
        type: "PLAIN_TEXT"
      },
      encodingType: "UTF8"
    }.to_json
  end

end
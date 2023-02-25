class GoogleSentimentService
  def self.get_sentiment(message)
    request = conn.post("/v1/documents:analyzeSentiment", self.google_query_format(message))
     
    JSON.parse(request.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: "https://language.googleapis.com") do |f|
      f.headers["content-type"] = 'text/plain'
      f.params["key"] = ENV["GOOGLE_API_KEY"]
    end
  end

  def self.google_query_format(input)
    {
      "document": {
        "content": input,
        "language": "",
        "type": "PLAIN_TEXT"
      },
      "encodingType": "UTF8"
    }.to_json
  end

end
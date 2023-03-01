class ActivitiesService
  def self.random_activity
    response = conn.get('activity')
    parse_json(response)
  end

  def self.conn
    Faraday.new(
      url: 'http://www.boredapi.com/api/'
    )
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

class ActivitiesFacade

  def self.random_activity
    json = ActivitiesService.random_activity
    activity_to_poro(json)
  end

  def self.activity_to_poro(json)
    Activity.new(json)
  end
end
class Activity
  attr_reader :activity

  def initialize(data)
    @activity = data[:activity]
  end
end

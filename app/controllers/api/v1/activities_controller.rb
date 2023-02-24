class Api::V1::ActivitiesController < ApplicationController
  def index
    render ActivitiesService.random_activity
  end
end
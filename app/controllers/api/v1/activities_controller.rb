class Api::V1::ActivitiesController < ApplicationController
  def index
    render json: ActivitiesFacade.random_activity
  end
end

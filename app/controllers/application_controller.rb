class ApplicationController < ActionController::API
  before_action :check_api_key

  def check_api_key
    if request.headers["FErn_key"] != ENV["FErn_key"]
      render status :unauthorized
    end
  end
end

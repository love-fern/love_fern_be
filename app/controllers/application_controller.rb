class ApplicationController < ActionController::API
  before_action :check_api_key

  def check_api_key
    unless request.headers.env["HTTP_FERN_KEY"] == ENV["FErn_key"]
      render status :unauthorized
    end
  end
end

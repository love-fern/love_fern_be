class ApplicationController < ActionController::API
  before_action :check_api_key

  def check_api_key
    unless request.headers.env["HTTP_FERN_KEY"] == ENV["FErn_key"]
      render json: { error: :unauthorized }, status: 403
    end
  end
end

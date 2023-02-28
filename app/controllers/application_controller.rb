class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  before_action :check_api_key

  def render_not_found(error)
    render json: ErrorSerializer.serialize(Error.new(error)), status: :not_found
  end

  def check_api_key
    unless request.headers.env["HTTP_FERN_KEY"] == ENV["FErn_key"]
      render json: { error: :unauthorized }, status: 403
    end
  end
end

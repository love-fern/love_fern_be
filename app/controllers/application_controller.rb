class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  before_action :check_api_key

  def render_not_found(error)
    render json: ErrorSerializer.serialize(Error.new(error)), status: :not_found
  end

  def check_api_key
    return if request.headers.env['HTTP_FERN_KEY'] == ENV['FERN_KEY']

    render json: { error: :unauthorized }, status: 403
  end
end

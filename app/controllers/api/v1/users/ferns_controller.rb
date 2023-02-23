class Api::V1::Users::FernsController < ApplicationController
  def index
    # binding.pry
    User.find_by_id(params[:user_id])
    render json: FernSerializer.new(Fern.where(user_id: params[:user_id]))
  end
end
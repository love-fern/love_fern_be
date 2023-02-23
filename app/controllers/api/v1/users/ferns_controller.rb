class Api::V1::Users::FernsController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    render json: FernSerializer.new(user.ferns)
  end

  def show
    render json: FernSerializer.new(Fern.find(params[:id]))
  end

  def create
    new_fern = Fern.create(fern_params)
    render json: FernSerializer.new(new_fern)
  end

  private

  def fern_params
    params.require(:fern).permit(:name, :frequency, :health, :shelf_id)
  end
end
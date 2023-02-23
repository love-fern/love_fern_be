class Api::V1::Users::FernsController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    render json: FernSerializer.new(user.ferns)
  end

  def show
    render json: FernSerializer.new(Fern.find(params[:id]))
  end

  def create
    
  end

  def update
    render json: FernSerializer.new(Fern.update(update_params))
  end

  private

  def update_params
    params.require(:fern).permit(:name, :frequency, :shelf_id, :preferred_contact_method)
  end
end
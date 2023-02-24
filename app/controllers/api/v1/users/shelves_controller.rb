class Api::V1::Users::ShelvesController < ApplicationController
  def create
    new_shelf = Shelf.create(shelf_params)
    render json: ShelfSerializer.new(new_shelf)
  end

  def update
    render json: ShelfSerializer.new(Shelf.update(update_params))
  end

  def destroy
    Shelf.find(params[:id]).destroy
  end

  def index
    user = User.find_by_google_id(params[:user_id])
    render json: ShelfFernSerializer.new(user.shelves)
  end

  private

  def update_params
    params.require(:shelf).permit(:name)
  end

  def shelf_params
    params.require(:shelf).permit(:name, :user_id)
  end
end
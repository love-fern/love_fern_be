class Api::V1::Users::ShelvesController < ApplicationController
  def create
    new_shelf = Shelf.create(shelf_params)
    render json: ShelfSerializer.new(new_shelf)
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id)
  end
end
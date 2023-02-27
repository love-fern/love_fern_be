class Api::V1::Users::ShelvesController < ApplicationController
  def create
    new_shelf = Shelf.new(shelf_params)
    if new_shelf.save
      render json: ShelfSerializer.new(new_shelf)
    else
      render json: ::ErrorsController.bad_request, status: 404
    end
  end

  def update
    shelf = Shelf.find(params[:id])
    if shelf.update(update_params)
      render json: ShelfSerializer.new(Shelf.update(update_params))
    else
      render json: ::ErrorsController.bad_request, status: 404
    end
  end

  def destroy
    Shelf.find(params[:id]).destroy
  end

  def index
    user = User.find_by_google_id(params[:user_id])
    options = { include: [:ferns] }
    render json: ShelfSerializer.new(user.shelves, options)
  end

  private

  def update_params
    params.require(:shelf).permit(:name)
  end

  def shelf_params
    params.require(:shelf).permit(:name, :user_id)
  end
end
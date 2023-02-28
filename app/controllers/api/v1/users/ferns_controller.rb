class Api::V1::Users::FernsController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    render json: FernSerializer.new(user.ferns)
  end

  def show
    options = { include: [:interactions, :user] }
    render json: FernSerializer.new(Fern.find(params[:id]), options)
  end

  def create
    user = User.find_by(google_id: params["user_id"])
    shelf = user.shelves.find_by(name: params["shelf"])
    new_fern = shelf.ferns.new(fern_params)
    if new_fern.save
      render json: FernSerializer.new(new_fern)
    else
      render json: ::ErrorsController.bad_request, status: 404
    end
  end

  def update
    fern = Fern.find(params[:id])
    if params[:interaction]
      fern.message_update(SentimentFacade.message_rating(params[:interaction]))
      fern.save
      render json: FernSerializer.new(fern)
    elsif fern.update(fern_params)
      render json: FernSerializer.new(Fern.update(update_params))
    else
      render json: ::ErrorsController.bad_request, status: 404
    end
  end

  def destroy
    Fern.find(params[:id]).destroy
  end

  private

  def update_params
    params.permit(:name, :shelf_id, :preferred_contact_method)
  end

  def fern_params
    params.permit(:name, :preferred_contact_method)
  end
end
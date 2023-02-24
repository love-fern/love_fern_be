class Api::V1::Users::FernsController < ApplicationController
  def index
    user = User.find_by_id(params[:user_id])
    render json: FernSerializer.new(user.ferns)
  end

  def show
    render json: FernSerializer.new(Fern.find(params[:id]))
  end

  def create
    user = User.find_by(google_id: params["user_id"])
    shelf = user.shelves.find_by(name: params["shelf"])
    new_fern = shelf.ferns.create(fern_params)
    render json: FernSerializer.new(new_fern)
  end

  def update
    fern = Fern.find(params[:id])
    if params[:message]
      fern.message_update(SentimentFacade.message_rating(params[:message]))
      fern.save
      render json: FernSerializer.new(fern)
    else
      render json: FernSerializer.new(Fern.update(update_params))
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
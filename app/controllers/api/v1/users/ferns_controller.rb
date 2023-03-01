class Api::V1::Users::FernsController < ApplicationController
  before_action :find_user, only: %i[index create]
  before_action :find_fern, only: %i[show update destroy]

  def index
    render json: FernSerializer.new(@user.ferns)
  end

  def show
    options = { include: %i[interactions user] }
    render json: FernSerializer.new(@fern, options)
  end

  def create
    shelf = @user.shelves.find_by(name: params['shelf'])
    new_fern = shelf.ferns.new(fern_params)
    if new_fern.save
      render json: FernSerializer.new(new_fern), status: 201
    else
      render json: ErrorSerializer.serialize(Error.new(new_fern.errors)), status: :unprocessable_entity
    end
  end

  def update
    params[:shelf_id] = find_shelf_id if params[:shelf]

    if params[:interaction]
      @fern.message_update(SentimentFacade.message_rating(params[:interaction]))
      @fern.save
      render json: FernSerializer.new(@fern)
    elsif @fern.update(update_params)
      @fern.save
      render json: FernSerializer.new(@fern)
    else
      render json: ErrorSerializer.serialize(Error.new(@fern.errors)), status: :unprocessable_entity
    end
  end

  def destroy
    @fern.destroy
    render json: FernSerializer.new(@fern)
  end

  private

  def update_params
    params.permit(:name, :shelf_id, :preferred_contact_method, :health)
  end

  def fern_params
    params.permit(:name, :preferred_contact_method)
  end
  
  def find_shelf_id
    Shelf.find_by(user: find_user, name: params[:shelf]).id
  end

  def find_user
    @user = User.find_by(google_id: params[:user_id])
  end

  def find_fern
    @fern = Fern.find(params[:id])
  end
end

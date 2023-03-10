class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.find_or_create_by(google_id: user_params[:google_id]) do |user|
      user.google_id = user_params[:google_id]
      user.name = user_params[:name]
      user.email = user_params[:email]
    end
    render json: UserSerializer.new(new_user)
  end

  def update
    user = User.find_by_id(params[:id])
    if user.update(name_param)
      render json: UserSerializer.new(User.update(name_param))
    else
      render json: ErrorSerializer.serialize(Error.new(user.errors)), status: :unprocessable_entity
    end
  end

  private

  def name_param
    params.require(:user).permit(:name)
  end

  def user_params
    params.permit(:name, :email, :google_id)
  end
end

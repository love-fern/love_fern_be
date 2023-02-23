class Api::V1::UsersController < ApplicationController
  def create
    render json: UserSerializer.new(User.create(user_params))
  end

  def update
    render json: UserSerializer.new(User.update(name_param))
  end

  private

  def name_param
    params.require(:user).permit(:name)
  end

  def user_params
    params.require(:user).permit(:name, :email, :google_id)
  end
end
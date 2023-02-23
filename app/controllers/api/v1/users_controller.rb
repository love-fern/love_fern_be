class Api::V1::UsersController < ApplicationController
  def create
    render json: UserSerializer.new(User.create(user_params))
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :google_id)
  end
end
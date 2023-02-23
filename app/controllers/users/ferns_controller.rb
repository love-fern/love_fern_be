class Api::V1::Users::FernsController
  def index
    @user = UserSerializer.new
  end
end
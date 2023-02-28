class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :google_id
end

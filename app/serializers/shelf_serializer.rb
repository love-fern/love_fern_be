class ShelfSerializer
  include JSONAPI::Serializer
  attributes :user_id, :name
end 
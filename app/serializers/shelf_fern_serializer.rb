class ShelfFernSerializer
  include JSONAPI::Serializer
  attributes :user_id, :name, :ferns
end 
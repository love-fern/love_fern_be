class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :health, :shelf_id
end
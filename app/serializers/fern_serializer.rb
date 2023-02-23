class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :frequency, :health, :shelf_id
end
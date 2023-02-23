class FernsSerializer
  include JSONAPI::Serializer
  attributes :name, :duration, :tag, :health, :user_id
end
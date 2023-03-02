class InteractionSerializer
  include JSONAPI::Serializer
  attributes :evaluation, :description, :created_at
  belongs_to :fern
end

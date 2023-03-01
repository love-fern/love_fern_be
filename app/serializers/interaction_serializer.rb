class InteractionSerializer
  include JSONAPI::Serializer
  attributes :evaluation, :created_at
  belongs_to :fern
end

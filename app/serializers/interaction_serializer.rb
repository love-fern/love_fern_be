class InteractionSerializer
  include JSONAPI::Serializer
  attributes :evaluation
  belongs_to :fern
end
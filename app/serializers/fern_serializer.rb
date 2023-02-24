class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :health, :preferred_contact_method
  belongs_to :shelf
end
class ShelfSerializer
  include JSONAPI::Serializer
  attributes :name
  belongs_to :user
  has_many :ferns
end 
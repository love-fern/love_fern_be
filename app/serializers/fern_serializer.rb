class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :health, :preferred_contact_method
  
  belongs_to :shelf
  has_one :user
  has_many :interactions do |fern, params|
    if params[:stats]
      fern.interactions.order(created_at: :desc)
    else
      fern.interactions.order(created_at: :desc).first(3)
    end
  end
end

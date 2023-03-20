class FernSerializer
  include JSONAPI::Serializer
  attributes :name, :health, :preferred_contact_method
  attribute :health_history, if: Proc.new { |fern, params|
    params[:stats]
  } do |fern|
    fern.health_history
  end
  
  has_many :interactions do |fern|
    fern.interactions.order(created_at: :desc).first(3)
  end
  has_many :interactions, if: Proc.new { |fern, params| params[:stats] }
  belongs_to :shelf
  has_one :user
end

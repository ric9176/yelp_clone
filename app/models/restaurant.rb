class Restaurant < ActiveRecord::Base
  has_many :reviews,
  -> { extending WithUserAssociationExtension },
      dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}


  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

end

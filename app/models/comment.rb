class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: { maximum: 248 }
end

class Post < ActiveRecord::Base
	acts_as_votable
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :image_link, presence: true, length: { maximum: 2048 }
  validates :buy_link, presence: true, length: { maximum: 2048 }
end

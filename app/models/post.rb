class Post < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :category
  default_scope -> { highest_score }#order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :image_link, presence: true, length: { maximum: 2048 }
  validates :buy_link, presence: true, length: { maximum: 2048 }

  def self.highest_score
  	self.order(:cached_votes_score => :desc)	
  end

  def self.search(search)
    where("image_link like ?", "%#{search}%")
    where("buy_link like ?", "%#{search}%")
  end


end

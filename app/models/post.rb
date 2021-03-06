class Post < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :category
  default_scope -> { highest_score }#order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category_id, presence: { message: "missing. Please assign an existing category." }
  validates :image_link, presence: true, length: { maximum: 2048 }
  validates :buy_link, presence: true, length: { maximum: 2048 }

  def self.highest_score
  	self.order(:cached_votes_score => :desc).order(:created_at => :desc)	
  end

  def self.search(search)
    where("lower(image_link) like ? or lower(buy_link) like ?", "%#{search}%".downcase, "%#{search}%".downcase)
  end


end

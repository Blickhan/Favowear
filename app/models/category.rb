class Category < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :followings, foreign_key: :category_id, dependent: :destroy
	has_many :users, through: :followings 
	validates :name, uniqueness: true, presence: true,
										length: { maximum: 20 }
	VALID_CATEGORY_REGEX = /\A[A-Za-z0-9-]+\z/
	validates :slug, uniqueness: true, presence: true, format: { with: VALID_CATEGORY_REGEX,
																message: ' must only include letters, numbers, and hyphens'},
										length: { maximum: 20 }, exclusion: { in: ['new','all']}
	validates :description, length: { maximum: 64 }

	def to_param
		slug
	end

	def self.search(search)
    where("lower(name) like ? or lower(slug) like ? or lower(description) like ?", 
    	"%#{search}%".downcase, "%#{search}%".downcase, "%#{search}%".downcase)
  end

end

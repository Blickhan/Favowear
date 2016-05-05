class Category < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :followings, foreign_key: :category_id, dependent: :destroy
	has_many :users, through: :followings 
	validates :name, uniqueness: true, presence: true
	VALID_CATEGORY_REGEX = /\A[A-Za-z0-9_-]+\z/
	validates :slug, uniqueness: true, presence: true, format: { with: VALID_CATEGORY_REGEX }

	def to_param
		slug
	end

end

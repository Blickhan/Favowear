class Category < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	validates :name, uniqueness: true, presence: true
	validates :slug, uniqueness: true, presence: true, format: { without: /\s/ }

	def to_param
		slug
	end

end

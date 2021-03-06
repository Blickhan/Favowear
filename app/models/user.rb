class User < ActiveRecord::Base
	acts_as_voter
	has_many :posts, dependent: :destroy
	has_many :followings, foreign_key: :user_id, dependent: :destroy
	has_many :categories, through: :followings
	has_many :comments
	attr_accessor :remember_token	

	#before_save { self.username = username.downcase }
	VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/
	validates :username, presence: true, length: { minimum: 3, maximum: 20 },
												format: { with: VALID_USERNAME_REGEX },
												uniqueness: { case_sensitive: false },
												exclusion: { in: ['new']}
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

	def to_param
		username
	end

	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		                                              BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
	  SecureRandom.urlsafe_base64
	end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
  	following_ids = "SELECT category_id FROM followings WHERE  user_id = :user_id"
    Post.where("category_id IN (#{following_ids})", user_id: id)
  end

	def follow(category)
		followings.create(category_id: category.id)
	end

	def unfollow(category)
		followings.find_by(category_id: category.id).destroy
	end

	def following?(category)
		categories.include?(category)
	end

	def self.search(search)
		where("lower(username) like ?", "%#{search}%".downcase)
	end

	def increase_stylepoints(count = 1)
		update_attribute(:stylepoints, stylepoints + count)
	end

	def decrease_stylepoints(count = 1)
		update_attribute(:stylepoints, stylepoints - count)
	end

end

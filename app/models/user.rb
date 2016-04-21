class User < ActiveRecord::Base
	#before_save { self.username = username.downcase }
	VALID_USERNAME_REGEX = /\A[A-Za-z0-9_-]+\z/
	validates :username, presence: true, length: { minimum: 6, maximum: 20 },
												format: { with: VALID_USERNAME_REGEX },
												uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }
end

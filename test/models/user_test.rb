require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
	def setup
		@user = User.new(username: "NewUser", password: "password",
											password_confirmation: "password")
	end

	test "invalid usernames" do
		invalid_usernames = "A AAAAAAAA", "a%aaaaaaaa", "a" * 21, "a" * 5, " " * 8
		invalid_usernames.each do |invalid_username|
			@user.username = invalid_username
			assert_not @user.valid?
		end
	end

	test "valid username" do
		@user.username = "User_name69"
		assert @user.valid?
	end

	test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

end

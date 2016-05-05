class FollowingsController < ApplicationController
	before_action :logged_in_user
	
	def create
		@category = Category.find(params[:category_id])
		@following = current_user.follow(@category)
		respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
	end

	def destroy
		@category = Following.find(params[:id]).category
		current_user.unfollow(@category)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
	end


end

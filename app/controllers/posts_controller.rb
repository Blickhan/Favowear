class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
	before_action :correct_user,   only: :destroy
	before_action :posting_too_much, only: :create

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
				@post.upvote_from current_user
				flash[:success] = "Post created."
				redirect_to root_url
		else
			render 'new'
		end
	end

	def show
  	@post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc).all
  end

	def destroy
		@post.destroy
    #flash[:success] = "Post deleted"
    respond_to do |format|
	    format.html {redirect_to current_user }
	    format.js
	  end
	end

	def upvote
			@post = Post.find(params[:id])
			@post.upvote_by current_user
			@post.user.increase_stylepoints if @post.user != current_user
			respond_to do |format|
		    format.html {redirect_to :back }
		    format.js
		  end
	end

	def downvote
			@post = Post.find(params[:id])
			@post.downvote_by current_user
			@post.user.decrease_stylepoints if @post.user != current_user
			respond_to do |format|
		    format.html {redirect_to :back }
		    format.js
		  end
	end

	private

		def post_params
      params.require(:post).permit(:image_link, :buy_link, :category_id)
    end

     def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      if @post.nil? && current_user.admin?
      	@post = Post.find(params[:id])
      end

      redirect_to root_url if @post.nil?
    end

    def posting_too_much
    	posts_per_hour = 5
    	if current_user.posts.where('created_at > ?', 1.hour.ago).count >= posts_per_hour && !current_user.admin?
    		flash[:danger] = "You're posting too much. Five posts per hour are allowed."
    		redirect_to new_post_path
    	end
    end

end

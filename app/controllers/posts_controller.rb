class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
	before_action :correct_user,   only: :destroy

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
			render 'static_pages/home'
		end
	end

	def show
  	@post = Post.find(params[:id])
    @comments = @post.comments.all
  end

	def destroy
		@post.destroy
    flash[:success] = "Post deleted"
    redirect_to current_user
	end

	def upvote
			@post = Post.find(params[:id])
			@post.upvote_by current_user
			redirect_to :back
	end

	def downvote
			@post = Post.find(params[:id])
			@post.downvote_by current_user
			redirect_to :back
	end

	private

		def post_params
      params.require(:post).permit(:image_link, :buy_link)
    end

     def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end

class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back }
        format.js
      end
    else
      flash[:danger] = "Comment cannot be blank"
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    
    respond_to do |format|
      format.html {redirect_to :back }
      format.js
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :body, :user_id)
    end

    def correct_user
      @comment = Comment.find(params[:id])
      redirect_to root_url unless @comment.user = current_user || current_user.admin?
    end
end

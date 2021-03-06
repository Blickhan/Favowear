class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
  before_action :correct_user, only: [:destroy]
  before_action :commenting_too_much, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      @comment.upvote_by current_user
      flash[:success] = "Comment created"
      redirect_to :back
      #respond_to do |format|
      #  format.html {redirect_to :back }
      #  format.js
      #end
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

  def upvote
      @comment = Comment.find(params[:id])
      # if already upvoted and button got clicked, unupvote and remove stylepoint
      if current_user.voted_up_on? @comment
        @comment.unliked_by current_user
        #@comment.user.decrease_stylepoints if @post.user != current_user
        respond_to do |format|
          format.html {redirect_to :back }
          format.js { render 'unvote.js.erb' }
        end
      else
        @comment.upvote_by current_user
        #@comment.user.increase_stylepoints if @post.user != current_user
        respond_to do |format|
          format.html {redirect_to :back }
          format.js
        end
      end
  end

  def downvote
      @comment = Comment.find(params[:id])
      # if already downvoted and button got clicked, undownvote and give post.user back stylepoint
      if current_user.voted_down_on? @comment
        @comment.undisliked_by current_user
        #@comment.user.increase_stylepoints if @post.user != current_user
        respond_to do |format|
          format.html {redirect_to :back }
          format.js { render 'unvote.js.erb' }
        end
      else
        @comment.downvote_by current_user
        #@comment.user.decrease_stylepoints if @post.user != current_user
        respond_to do |format|
          format.html {redirect_to :back }
          format.js
        end
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

    def commenting_too_much
      comments_per_hour = 10
      if current_user.comments.where('created_at > ?', 5.minutes.ago).count >= comments_per_hour && !current_user.admin?
        flash[:danger] = "You're commenting too much."
        redirect_to :back
      end
    end
end

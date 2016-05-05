class StaticPagesController < ApplicationController
  def home
  	@feed_items = current_user.feed.paginate(page: params[:page])#Post.all.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end

  
end

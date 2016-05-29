class StaticPagesController < ApplicationController
  before_action :get_feed, only: [:home, :filter_posts]


  def home
    @date_filter = session[:date_filter] || 1
    @feed_items = filter_by_date(@date_filter).paginate(page: params[:page], per_page: 32)
  end

  def filter_posts
    @date_filter = params[:date_filter]
    session[:date_filter] =  @date_filter
    @feed_items = filter_by_date(@date_filter).paginate(page: params[:page], per_page: 32)

    respond_to do |format|
        format.html {redirect_to :back }
        format.js
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def search
    @search_term = params[:search]
    @users = User.all
    @categories = Category.all
    @posts = Post.all

    if params[:search]
      @users = @users.search(@search_term).paginate(page: params[:page], per_page: 6)
      @categories = @categories.search(@search_term).paginate(page: params[:page], per_page: 6)
      @posts = @posts.search(@search_term).paginate(page: params[:page], per_page: 8)
    else
      redirect_to root_path
    end

  end

  def sitemap
  end

  

  private

    def get_feed
      if logged_in?
        @feed_items = current_user.feed
      else
        @feed_items = Post.joins(:category).where(categories: { is_default: true })
      end
    end

    def filter_by_date(date_filter)
      case date_filter
        when '1' #day
          @feed_items.where(:created_at => 1.day.ago..Time.now)
        when '2' #week
          @feed_items.where(:created_at => 7.day.ago..Time.now)
        when '3' #month
          @feed_items.where(:created_at => 31.day.ago..Time.now)
        when '4' #year
          @feed_items.where(:created_at => 365.day.ago..Time.now)
        when '5' #all time
          @feed_items
        when '6' #newest
          @feed_items.reorder('created_at DESC')
        else
          @feed_items.where(:created_at => 1.day.ago..Time.now)
      end
    end
  
end

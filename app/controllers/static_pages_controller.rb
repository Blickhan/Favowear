class StaticPagesController < ApplicationController
  before_action :get_feed, only: [:home, :filter_posts]


  def home
    @date_filter = session[:date_filter] || 1
    @feed_items = filter_by_date(@date_filter)
  end

  def filter_posts
    @date_filter = params[:date_filter]
    session[:date_filter] =  @date_filter
    @feed_items = filter_by_date(@date_filter).paginate(page: params[:page])

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

  

  private

    def get_feed
      if logged_in?
        @feed_items = current_user.feed.paginate(page: params[:page])
      else
        @feed_items = Post.joins(:category).where(categories: { is_default: true }).paginate(page: params[:page])
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
        else
          @feed_items.where(:created_at => 1.day.ago..Time.now)
      end
    end
  
end

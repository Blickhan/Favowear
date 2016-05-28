class CategoriesController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :admin_user,     only: [:edit, :update, :destroy]
	before_action :find_category, only: [:show, :edit, :update, :destroy, :filter_posts]
  before_action :creating_too_much, only: :create

	def new 
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
    	flash[:success] = "Category created."
      redirect_to categories_path
    else
      render 'new'
    end
	end

	def edit

	end

	def update
		if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to categories_path
    else
      render 'edit'
    end
	end

	def destroy
		@category.destroy
    flash[:success] = "Category deleted"
    redirect_to categories_path
	end

	def index
    if params[:term]
      @categories = Category.where('lower(name) like ?', "%#{params[:term].downcase}%")
    else
  		@categories = Category.all.order(:name).paginate(page: params[:page])
    end

    respond_to do |format|
      format.html

      format.json { render :json => @categories.to_json }
    end
	end

	def show
		@date_filter = session[:date_filter] || 1
  	#@category = Category.find_by(slug: params[:slug])
    @posts = @category.posts.all
    @posts = filter_by_date(@date_filter).paginate(page: params[:page])
  end

  def filter_posts
  	
    @date_filter = params[:date_filter]
    session[:date_filter] =  @date_filter

    @posts = @category.posts.all
    @posts = filter_by_date(@date_filter).paginate(page: params[:page])

    respond_to do |format|
        format.html {redirect_to :back }
        format.js
    end
  end

	private

    def category_params
      if current_user.admin?
        params.require(:category).permit(:name, :slug, :description, :is_default)
      else
        params.require(:category).permit(:name, :slug, :description)
      end
    end    

    def find_category
    	@category = Category.find_by_slug!(params[:id])
    end

    def filter_by_date(date_filter)
      case date_filter
        when '1' #day
          @posts.where(:created_at => 1.day.ago..Time.now)
        when '2' #week
          @posts.where(:created_at => 7.day.ago..Time.now)
        when '3' #month
          @posts.where(:created_at => 31.day.ago..Time.now)
        when '4' #year
          @posts.where(:created_at => 365.day.ago..Time.now)
        when '5' #all time
          @posts
        else
          @posts.where(:created_at => 1.day.ago..Time.now)
      end
    end

    def creating_too_much
      categories_per_period = 2
      if Category.where('user_id = ? and created_at > ?', current_user.id, 15.minutes.ago).count >= categories_per_period && !current_user.admin?
        flash[:danger] = "You're creating categories too much. Two categories per 15 minutes are allowed."
        redirect_to new_category_path
      end
    end

end

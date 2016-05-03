class CategoriesController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
	before_action :find_category, only: [:show, :edit, :update, :destroy]

	def new 
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
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
      redirect_to @category
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
		@categories = Category.all.order(:name)
	end

	def show
  	#@category = Category.find_by(slug: params[:slug])
    @posts = @category.posts.paginate(page: params[:page])
  end

	private

    def category_params
      params.require(:category).permit(:name, :slug, :description)
    end    

    def find_category
    	@category = Category.find_by_slug!(params[:id])
    end

end

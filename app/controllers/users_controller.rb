class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :categories]
  before_action :correct_user,   only: [:edit, :update, :categories]
  before_action :admin_user,     only: [:index, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy, :categories]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	#@user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      follow_default_categories      
    	flash[:success] = "Welcome aboard!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    #User.find(params[:id]).destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # allows users to see their followed categories
  def categories
    @categories = @user.categories.order(:name).paginate(page: params[:page])
    render 'show_categories'
  end

  private

    def user_params
      params.require(:user).permit(:username, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      #@user = User.find(params[:id])
      find_user
      redirect_to(root_url) unless @user == current_user || current_user.admin?
    end

    def find_user
      @user = User.find_by_username!(params[:id])
    end

    def follow_default_categories
      Category.where(is_default: true).each do |category|
        @user.follow(category)
      end
    end

end

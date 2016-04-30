class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  	# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless logged_in? && current_user.admin?
    end

    def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end
    rescue ActionController::UnknownFormat
      render status: 404, text: "nope"
    end

    def record_not_found
    #redirect_to root_url
    #controller: :static_pages, action: :not_found
    redirect_to error_404_path
  end
end

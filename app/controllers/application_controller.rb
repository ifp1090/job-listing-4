class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = '你不是管理员'
      redirect_to jobs_path
    end
  end

  def require_is_super_admin
    if !current_user.super_admin?
      flash[:alert] = '你不是超级管理员'
      redirect_to jobs_path
    end
  end

  def require_is_not_admin
    if current_user.admin?
      flash[:alert] = '管理员不能进行这个操作'
      redirect_to jobs_path
    end
  end

  def after_sign_in_path_for(resource)
    jobs_path
  end

  protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	    user_params.permit(:email, :password, :password_confirmation, :is_admin)
	  end
	end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user_groups

  private
  
  def set_user_groups
  	@user_groups = current_user.groups.where(default_group: false) if user_signed_in?
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # any methods we build here will be availabel to all controllers

  helper_method :current_chef, :logged_in? # specifying that this is a helper_method, thes will be available to views as well

  def current_chef
    # if there is a current chef logged in use it (or - ||) if the id is in the session variable, find the chef and make it the current chef
      @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  # check to see if anyone is logged in
  def logged_in?
    !!current_chef # !! makes this a true or false statement
  end

  def require_user #not needed in the views so we don't put it in the helper_method specs
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end

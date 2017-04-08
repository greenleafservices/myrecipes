class SessionsController < ApplicationController

def new

end

def create
  session[:recipe_comment_id] = nil # used to pass recipe_id from _comments partial to the comments controller so that
  #                                  the comment edit Action can find its way back to the _recipe partial
  chef = Chef.find_by(email: params[:session][:email].downcase)
  if chef && chef.authenticate(params[:session][:password])
    session[:chef_id] = chef.id
    cookies.signed[:chef_id] = chef.id #used by Action Cable
    flash[:success] = "You have successfully logged in"
    #redirect_to chef_path(chef)
    redirect_to recipes_path
  else
  flash.now[:danger] = "There was something wrong with your login information"
    render 'new'
  end
end

def destroy
  session[:chef_id] = nil
  flash[:success] = "You have logged out"
  redirect_to root_path
end

end

class ChefsController < ApplicationController
# ************************************ Eliminate direct URL access to pages ********************************
  before_action :require_same_user, only: [:edit, :update, :destroy]
  #before_action :require_admin, only: [:destroy]
  # only the logged in chef is allowed access
  # **********************************************************************************************************

  def index
    #@chefs = Chef.sorted
    @chefs = Chef.sorted.paginate(page: params[:page], per_page: 10)
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.latest.paginate(page: params[:page], per_page: 2)
  end

  def new
    @chef = Chef.new
  end

  def create
    @adminFlag = 0
    if logged_in? #skip the next line for a new user creating his/her profile
      if current_chef.admin?
        @adminFlag = 1 # if this action is called by the admin, store the admin flag
      end
    end
    @chef = Chef.new(chef_params)
    if @chef.save
      if @adminFlag != 1 # if this is a new user creating his/her own profile, set the session id to the new user's id
        flash[:success] = "Welcome #{@chef.name} to the MyRecipes App!"
        session[:chef_id] = @chef.id
        redirect_to chef_path(@chef.id) # go to the new chef's profile page
      else
        flash[:success] = "Chef #{@chef.name} added to the MyRecipes App!"
        redirect_to chefs_path #Admin created this chef profile, show all the chefs_path
      end
    else
      render 'new'
    end
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Chef Profile was updated successfully!"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end

    def edit
      @chef = Chef.find(params[:id])
    end

    def delete
    end

    def destroy
      @chef = Chef.find(params[:id])
      if !@chef.admin?
        @chef.destroy
        flash[:danger] = "Chef and all associated recipes have been deleted"
        redirect_to chefs_path
      end
    end
  private

    def chef_params
      params.require(:chef).permit(:name, :email, :password, :password_confirmation, :comments)
    end

    def require_same_user # or admin
      @admin = 0 # reset the admin flag
      if logged_in? & current_chef.admin?
        @admin = 1 # if this action is called by the admin, store the admin flag
      end
      @chef = Chef.find(params[:id])
      if current_chef != @chef and @admin != 1
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to chefs_path
      end
    end

    # def require_admin
    #   if logged_in? & !current_chef.admin?
    #     flash[:danger] = "Only admin users can perform that action"
    #     redirect_to root_path
    #   end
    # end

end

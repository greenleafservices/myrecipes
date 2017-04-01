class ChefsController < ApplicationController
# ************************************ Eliminate direct URL access to pages ********************************
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # only the logged in chef is allowed access
  # **********************************************************************************************************

  def index
    #@chefs = Chef.sorted
    @chefs = Chef.sorted.paginate(page: params[:page], per_page: 5)
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.latest.paginate(page: params[:page], per_page: 2)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      # save the chef's parameters to the session variables
      session[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.name} to the MyRecipes App!"
      redirect_to chef_path(@chef)
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
      @chef.destroy
      flash[:danger] = "Chef and all associated recipes have been deleted"
      redirect_to chefs_path
    end
  private

    def chef_params
      params.require(:chef).permit(:name, :email, :password, :password_confirmation, :comments)
    end

    def require_same_user
      if current_chef != @chef
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to chefs_path
      end
    end

end

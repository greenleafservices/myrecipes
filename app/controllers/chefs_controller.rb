class ChefsController < ApplicationController
  def index
    @chefs = Chef.all
  end

  def show
    @chef = Chef.find(params[:id])
  end

  def new
    @chef = Chef.new
  end

  def create
    debugger
    @chef = Chef.new(chef_params)

    if @chef.save
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
    Chef.find(params[:id]).destroy
    flash[:success] = "Chef Profile was deleted successfully!"
    redirect_to chefs_path
  end
  private

    def chef_params
      params.require(:chef).permit(:name, :email, :password, :password_confirmation)
    end
  end

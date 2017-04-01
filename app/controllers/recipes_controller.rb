class RecipesController < ApplicationController

  # ************************************ Eliminate direct URL access to pages ********************************
    before_action :require_user, except: [:index, :show] # this is from the application controller
    before_action :require_same_user, only: [:edit, :update, :destroy] # only the chef who created the recipe is allowed access
    # **********************************************************************************************************
  def index
    #@recipes = Recipe.all
    @recipes = Recipe.latest.paginate(page: params[:page], per_page: 3)
  end

  def show
    @recipe = Recipe.find(params[:id]) #get the recipe data
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef #the chef who is logged in
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id]) #get the recipe data
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id]) #get the recipe data
  end

  def delete
  end

  def destroy
    Recipe.find(params[:id]).destroy #get the recipe data, set the action
    flash[:success] = "Recipe was deleted successfully!"
    redirect_to recipes_path
  end
  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end

  def require_same_user
    @recipe = Recipe.find(params[:id]) #get the recipe data
    if current_chef != @recipe.chef
      flash[:danger] = "You can only edit or delete your own recipes"
      redirect_to recipes_path
    end
  end
end

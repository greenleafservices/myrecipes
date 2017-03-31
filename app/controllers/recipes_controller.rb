class RecipesController < ApplicationController
  def index
    #@recipes = Recipe.all
    @recipes = Recipe.latest.paginate(page: params[:page], per_page: 3)
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def edit
  @recipe = Recipe.find(params[:id])
end

  def delete
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe was deleted successfully!"
    redirect_to recipes_path
  end
  private

    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end

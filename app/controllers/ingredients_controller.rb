class IngredientsController < ApplicationController

  before_action :require_admin, except: [:show, :index]

  def index
    @ingredients = Ingredient.sorted.paginate(page: params[:page], per_page: 10)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 10)
  end

  def edit_ingredient_path
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was successfully created"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient name was updated successfully"
      redirect_to @ingredient
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    @ingredient = Ingredient.find(params[:id]).destroy
    flash[:success] = "Ingredient was deleted successfully!"
    redirect_to ingredients_path
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_chef.admin?)
        flash[:danger] = "Only admin users can perform that action"
        redirect_to ingredients_path
      end
    end


end

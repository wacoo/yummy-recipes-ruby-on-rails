class RecipesController < ApplicationController
  before_action :authenticate_user!
  layout 'application'
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe created successfully.'
    else
      flash.now[:error] = 'Recipe not created. Try again!'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    puts @recipe
    redirect_to recipes_path, alert: 'Recipe deleted successfully.'
    # else
    #     puts 'DDDD'
    #     redirect_to recipes_path,  alert: "Failed to delete the recipe #{@recipe.id}"
    # end
  end

  def shopping_list
    @user = current_user
    @recipes = @user.recipes.includes(:foods)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end

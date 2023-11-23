class RecipeFoodsController < ApplicationController
  layout 'application'
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      flash[:success] = 'Recipe food created successfully!'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash.now[:error] = 'Failed to create recipe food.'
      render :new
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end

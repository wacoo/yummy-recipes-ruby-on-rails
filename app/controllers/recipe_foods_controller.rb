class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to recipe_path(params[:recipe]), success: 'Recipe food created successfully.'
    else
      flash.now[:error] = 'Failed to create recipe food.'
      render :new
    end
  end
end

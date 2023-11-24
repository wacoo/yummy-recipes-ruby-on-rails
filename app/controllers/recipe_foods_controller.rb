class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout 'application'
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      flash[:notice] = 'Recipe food created successfully!'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash.now[:error] = 'Failed to create recipe food.'
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Food item deleted successfully.'
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end

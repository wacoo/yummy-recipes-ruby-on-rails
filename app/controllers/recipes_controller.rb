class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout 'application'
  def index
    @recipes = current_user.recipes.includes(:user)
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

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    puts @recipe
    redirect_to recipes_path, alert: 'Recipe deleted successfully.'
  end

  def public_recipes
    @recipes = Recipe.where(public: true).includes(:user)
  end

  def general_shopping_list
    @user = current_user
    @recipes = @user.recipes.includes(foods: :recipe_foods)
  
    @shopping_list = []
  
    @recipes.each do |recipe|
      puts recipe.name
      recipe.foods.each do |food|
        available_quantity = food.quantity
        required_quantity = recipe.recipe_foods.find_by(food_id: food.id).quantity
        quantity_to_shop = required_quantity - available_quantity
  
        if quantity_to_shop > 0
          @shopping_list << {
            recipe_name: recipe.name,
            food_name: food.name,
            quantity_to_shop: quantity_to_shop,
            price: food.price * quantity_to_shop,
            measurement_unit: food.measurement_unit
          }
        end
      end
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end

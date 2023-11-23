class FoodsController < ApplicationController
  layout 'application'
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to @food, notice: 'Food created successfully.'
    else
      flash[:error] = 'Failed to create food.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.user = current_user
    if @food.destroy
      redirect_to foods_path, notice: 'Food removed successfully.'
    else
      redirect_to foods_path, error: 'Failed to remove food.'
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end

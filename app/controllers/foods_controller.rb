class FoodsController < ApplicationController
  layout 'application'
  def index
    @foods = current_user.foods.includes(:user)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to foods_path, notice: 'Food created successfully.'
    else
      flash[:error] = 'Failed to create food.'
      render :new
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      redirect_to @food, notice: 'Food was successfully modified.'
    else
      puts 'SDSDS'
      flash[:notice] = 'Failed to update food.'
      render :edit
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end

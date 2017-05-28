class DishesController < ApplicationController
  before_action :find_restaurant
  before_action :find_restaurant_dish, only: [:show, :update, :destroy]

  def index
    render json: @restaurant.dishes, status: :ok
  end

  def create
    @dish = @restaurant.dishes.create!(dish_params)
    render json: @dish, status: :created
  end

  def show
    render json: @dish, status: :ok
  end

  def update
    @dish.update(dish_params)
    head :no_content
  end

  def destroy
    @dish.destroy
    head :no_content
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def find_restaurant_dish
    @dish = @restaurant.dishes.find(params[:id]) if @restaurant
  end

  def dish_params
    params.permit(:dish, :price)
  end
end

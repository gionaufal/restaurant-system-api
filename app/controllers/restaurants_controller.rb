class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all
    render json: @restaurants, status: :ok
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    render json: @restaurant, status: :created
  end

  def show
    render json: @restaurant, status: :ok
  end


  def update
    @restaurant.update(restaurant_params)
    head :no_content
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.permit(:name)
  end
end

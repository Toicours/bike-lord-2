class RentalsController < ApplicationController
  require 'date'
before_action :find_bike, only: [:new, :create, :show, :edit, :update, :destroy]
before_action :find_rental, only: [:edit, :update, :destroy]

  def new
    @rental = Rental.new
    authorize @bike

  end

  def create
    authorize @bike
    @rental = Rental.new(rental_params)
    @user = @bike.user
    @rental.bike = @bike
    @rental.user = current_user
    @rental.total_price = @bike.price * (params["rental"]["end_date"].to_date - params["rental"]["start_date"].to_date).to_i
    if @rental.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    authorize @bike
  end

  def edit
    find_rental
    authorize @bike
  end

  def update
    @rental.update(rental_params)
    authorize @bike
    redirect_to dashboard_path
  end

  def destroy
    @rental.destroy
    redirect_to dashboard_path
  end

  private

  def rental_params
    params.require(:rental).permit(:total_price, :user_id, :bike_id, :start_date, :end_date)
  end

  def find_bike
    @bike = Bike.find(params[:bike_id])
  end

  def find_rental
    @rental = Rental.find(params[:id])
  end
end

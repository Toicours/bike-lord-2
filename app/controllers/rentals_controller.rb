class RentalsController < ApplicationController
  require 'date'
before_action :find_bike, only: [:new, :create, :show, :edit, :update, :destroy]
before_action :find_rental, only: [:edit, :update, :destroy]

  def new
    @rental = Rental.new
    authorize @bike
    @start = session[:start_date]
    @end = session[:end_date]
  end

  def create
    authorize @bike
    @rental = Rental.new(rental_params)
    @user = @bike.user
    @rental.bike = @bike
    @rental.user = current_user
    @start = Date.parse(session[:start_date])
    @end = Date.parse(session[:end_date])
    @rental.total_price = @bike.price * (@end - @start).to_i
    if @rental.saveDate.parse(session[:start_date])
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

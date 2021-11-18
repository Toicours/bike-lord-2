class RentalsController < ApplicationController
  def new
    @bike = Bike.find(params[:bike_id])
    @rental = Rental.new
    authorize @bike
  end

  def create
    @user = User.find(params[:user_id])
    @bike = Bike.find(params[:bike_id])
    @rental = Rental.new(rental_params)
    authorize @bike
    @rental.user_id = @user.id
    @rental.bike_id = @bike.id
    if @rental.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:total_price, :user_id, :bike_id, :start_date, :end_date)
  end
end

class BikesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @bikes = policy_scope(Bike).order(created_at: :desc)
  end

  def show
    @bike = Bike.find(params[:id])
  end

  def new
    authorize @bike
    @bike = Bike.new
  end

  def create
    authorize @bike
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :price, :description, :category, :available, :image)
  end
end

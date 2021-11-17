class BikesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_bike, only: [:show, :destroy]

  def index
    @bikes = policy_scope(Bike).order(created_at: :desc)
  end

  def show
    authorize @bike
  end

  def new
    @bike = Bike.new
    authorize @bike
  end

  def create
    @bike = Bike.new(bike_params)
    authorize @bike
    @bike.user = current_user
    if @bike.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    authorize @bike
    @bike.destroy
    redirect_to root_path
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :price, :description, :category, :available, :image)
  end

  def find_bike
    @bike = Bike.find(params[:id])
  end
end

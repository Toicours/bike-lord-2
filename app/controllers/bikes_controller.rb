class BikesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_bike, only: [:show, :edit, :update, :destroy]
  def index
    @bikes = policy_scope(Bike)
    if params[:query].present? && params[:end_date].present? && params[:start_date].present?
      @bikes = Bike.search_by_name_description_category(params[:query]).select {|bike| bike.availability?(params[:start_date], params[:end_date]) }
      @markers = @bikes.map do |bike|
        if bike.category == "Bike"
          image = "VehicleBike.png"
        elsif bike.category == 'Electric Bike'
          image = "VehicleElectricBike.png"
        elsif bike.category == 'Moto'
          image = "VehicleMoto.png"
        elsif bike.category == 'Scooter'
          image = "VehicleScooter.png"
        elsif bike.category == 'Monocycle'
          image = "VehicleMonocycle.png"
        end
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
        image_url: helpers.asset_url(image)
      }
      end
      p "DEBUG"
      p @markers
    else
      @bikes = policy_scope(Bike).order(created_at: :desc)
      @markers = @bikes.geocoded.map do |bike|
        if bike.category == "Bike"
          image = "VehicleBike.png"
        elsif bike.category == 'Electric Bike'
          image = "VehicleElectricBike.png"
        elsif bike.category == 'Moto'
          image = "VehicleMoto.png"
        elsif bike.category == 'Scooter'
          image = "VehicleScooter.png"
        elsif bike.category == 'Monocycle'
          image = "VehicleMonocycle.png"
        end
        {
          lat: bike.latitude,
          lng: bike.longitude,
          info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
          image_url: helpers.asset_url(image)
        }
      end
    end
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
    # @bike.address = @bike.user.address
    if @bike.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    authorize @bike
  end

  def update
    @bike.update(bike_params)
    authorize @bike
    redirect_to dashboard_path
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

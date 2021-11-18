class BikesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_bike, only: [:show, :destroy]


  def index
    @bikes = policy_scope(Bike).order(created_at: :desc)
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window: render_to_string(partial: "info_window", locals: { bike: bike }),

        # if bike.category == "Bike"
        #   image_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
        # elsif bike.category == 'Electric Bike'
        #   image_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
        # elsif bike.category == 'Scooter'
        #   image_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
        # elsif bike.category == 'Moto'
        #   image_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
        # elsif bike.category == 'Monocycle'
        #   image_url: helpers.asset_url("REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS")
        # end
      }
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
      raise
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

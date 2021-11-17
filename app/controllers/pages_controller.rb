class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def dashboard
    @user = current_user
    @rentals = @user.rentals
    @bikes = @user.bikes
  end
  def home
  end
end

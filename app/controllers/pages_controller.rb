class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @rentals = @user.rentals
    @bikes = @user.bikes
  end
end

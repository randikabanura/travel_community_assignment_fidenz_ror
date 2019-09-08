class TripsController < ApplicationController

  before_action :trip_params, only: [:create]

  def index

  end

  def new
    @trip = Trip.new
    if Trip.exists?(user_id: current_user.id)
      @my_trips = Trip.all.where(user: current_user)
    else
      @my_trips = nil
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user if current_user
    if @trip.save
      flash[:notice] = "Trip was saved successfully."
      redirect_to @trip
    else
      flash.now[:alert] = "Error creating Trip. Please make sure there is a name and description."
      render :new
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:location, :date_s, :date_e, :description, :photos => [])
  end
end

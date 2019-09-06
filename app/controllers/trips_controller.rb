class TripsController <ApplicationController

  before_action :trip_params, only: [:create]
  def index

  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user if current_user
    if @trip.save
      flash.now[:notice] = "Assignment was saved successfully."
      render :new
    else
      flash.now[:alert] = "Error creating assignment. Please make sure there is a name and description."
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit( :location, :date_s, :date_e, :description, :photos => [])
  end
end

class TripsController <ApplicationController

  def index

  end

  def new
    @trip = Trip.new
  end

  def create
    #render plain: params[:trip].inspect
    @trip = Trip.new(trip_params)
    @trip.save
  end

  private

  def trip_params
    params.require(:trip).permit(:location, :date_s, :date_e, :description, :photos)
  end
end

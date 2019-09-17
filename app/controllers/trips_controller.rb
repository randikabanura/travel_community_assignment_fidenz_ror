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
      flash[:alert] = "Error creating Trip. Please make sure there is a correct location and dates."
      redirect_to new_trip_path
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:trip_id])
    @image.purge
    @trip = Trip.find(params[:id])
    respond_to do |format|
      format.js {render :file => 'trips/edit'}
    end
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      flash[:notice] = "Trip successfully updated"
      redirect_to trip_path(@trip)
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    if @trip.destroy
      flash[:danger] = "Trip successfully deleted"
      redirect_to new_trip_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:location, :date_s, :date_e, :description, :photos)
  end
end

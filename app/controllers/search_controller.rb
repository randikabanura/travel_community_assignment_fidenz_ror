class SearchController < ApplicationController

  def show
    @search_term = params[:search]
    @users = User.search(params[:search])
    @trips = Trip.search(params[:search])
  end
end

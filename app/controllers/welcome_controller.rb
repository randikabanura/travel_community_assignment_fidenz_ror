class WelcomeController < ApplicationController
  def index
    #@trips = Trip.order(Arel.sql('random')).limit(5)
    @trips = Trip.all
  end
end

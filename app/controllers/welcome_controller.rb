class WelcomeController < ApplicationController
  def index
    #@trips = Trip.order(Arel.sql('random')).limit(5)
    # User.order("RANDOM()").limit(10)
    @trips = Trip.order("RANDOM()").limit(3)
  end
end

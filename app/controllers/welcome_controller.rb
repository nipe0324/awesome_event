class WelcomeController < ApplicationController
  def index
    @events = Event.available
  end
end

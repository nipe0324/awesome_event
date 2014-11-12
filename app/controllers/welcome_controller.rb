class WelcomeController < ApplicationController
  def index
    @events = Event.available.page(params[:page])
  end
end

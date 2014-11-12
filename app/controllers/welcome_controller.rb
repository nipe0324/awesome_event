class WelcomeController < ApplicationController
  def index
    @q = Event.page(params[:page]).search(search_params)
    @events = @q.result(distinct: true)
  end

  private

  def search_params
    params.require(:q).permit(:name_cont, :start_time_gteq)
  rescue
    { start_time_gteq: Time.zone.now }
  end
end

class Admin::EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  private
  def event_params
    params.require(:event).permit(:competition_id, :name, :address, :venue, :day, :image, :tag_ids, :youtube_url)
  end
end

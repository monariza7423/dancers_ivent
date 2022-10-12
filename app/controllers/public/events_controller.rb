class Public::EventsController < ApplicationController
  def new
    @event = Event.new
    @competitions = Competition.all
  end
  
  def create
    event = Event.new(event_params)
    event.competition_id = 1
    tag_list = params[:event][:tag_names].split(',')
    event.save
    event.tags_save(tag_list)
    redirect_to user_path(current_user)
  end
  
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
    @event_comment = EventComment.new
  end
  
  private
  def event_params
    params.require(:event).permit(:competition_id, :name, :address, :venue, :day, :image, :video)
  end
end

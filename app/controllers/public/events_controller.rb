class Public::EventsController < ApplicationController
  def new
    @event = Event.new
    @competitions = Competition.all
  end
  
  def create
    event = Event.new(event_params)
    event.competition_id = 1
    tag_ids = params[:event][:tag_ids]
    selected_tag = Tag.where(id: tag_ids)
    selected_tag_list = selected_tag.map{ |tag| tag.name }
    
    tag_list = params[:event][:tag_names].split(',')
    tag_list.push(selected_tag_list)
    # 動画投稿
    url = event.youtube_url
    url = url.last(11)
    event.youtube_url = url
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
  
  def search
    @events = Event.search(params[:keyword])
    @keyword = params[:keyword]
  end
  
  def search_tag
    @tag_list=Tag.all
    @tag = Tag.find(params[:tag_id])
    @events = @tag.events
  end
  
  private
  def event_params
    params.require(:event).permit(:competition_id, :name, :address, :venue, :day, :image, :tag_ids, :youtube_url)
  end
end

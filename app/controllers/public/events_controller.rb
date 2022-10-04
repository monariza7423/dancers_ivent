class Public::EventsController < ApplicationController
  def new
    @event = Event.new
    @competitions = Competition.all
  end
  
  def create
  end
end

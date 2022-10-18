class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @events = Event.looks(params[:search], params[:word])
  end
end
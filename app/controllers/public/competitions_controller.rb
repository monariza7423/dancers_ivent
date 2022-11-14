class Public::CompetitionsController < ApplicationController
  def new
    @competition = Competition.new
    @genres = Genre.all
  end
  
  def create
    competition = Competition.new(competition_params)
    competition.save
    redirect_to new_event_path
  end
  
  def index
    @competitions = Competition.all
  end
  
  def edit
    @competition = Competition.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    competition = Competition.find(params[:id])
    competition.update(competition_params)
    redirect_to competitions_path
  end
  
  def destroy
    competition = Competition.find(params[:id])
    competition.destroy
    redirect_to competitions_path
  end
  
  private
  def competition_params
    params.require(:competition).permit(:overview, :rule, :judge, :dj, :mc, :prize, :genre_id)
  end
end

class Public::CompetitionsController < ApplicationController
  def new
    @competition = Competition.new
  end
  
  def create
    competition = Competition.new(competition_params)
    competition.save
    redirect_to competitions_path
  end
  
  def index
    @competitions = Competition.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def competition_params
    params.require(:competition).permit(:overview, :rule, :judge, :dj, :mc, :prize)
  end
end

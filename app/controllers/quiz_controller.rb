class QuizController < ApplicationController

  def new
    @earth_view = EarthView.order('RANDOM()').first
    @choices = Country.where('id != ?', @earth_view.id).order('RANDOM()').first(3)
    @choices << @earth_view.country
    @choices.shuffle
  end

  def create
    answer = params['commit']
    current = EarthView.find params['current']
    redirect_to quiz_path(current, answer: answer)
  end

  def show
    @earth_view = EarthView.find params[:id]
    @good_answer = @earth_view.country.name == params[:answer]
  end
end

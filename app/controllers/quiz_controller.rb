class QuizController < ApplicationController
  def new
    @earth_view = EarthView.order('RANDOM()').first
    @choices = Country.where('id != ?', @earth_view.id).order('RANDOM()').first(3)
    @choices << @earth_view.country
  end
end

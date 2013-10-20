class SiteController < ApplicationController
  
  # too tired to care that I'm doing everything here
  def index
    @questions = Question.random_by_category
    @profile = Profile.new
    @profiles = Profile.completed
  end
  
  def privacy
  end
  
  def terms
  end
  
end
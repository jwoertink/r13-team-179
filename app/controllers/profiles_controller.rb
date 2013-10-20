class ProfilesController < ApplicationController
  
  def create
    
  end
  
  def show
    @profile = Profile.find(params[:key])
  end
  
  protected
  
  def profiles_params
    params.permit(:profile)
  end
  
end
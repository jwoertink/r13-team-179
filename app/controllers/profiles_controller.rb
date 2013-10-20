class ProfilesController < ApplicationController
  
  def create
    @profile = Profile.new(profile_params)
    @profile.save
    redirect_to root_path, notice: 'Your video will be available soon'
  end
  
  def show
    @profile = Profile.find(params[:key])
  end
  
  protected
  
  def profile_params
    params.require(:profile).permit(:email, :url_key, :question_ids, )
  end
  
end
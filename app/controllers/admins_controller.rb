class AdminsController < ApplicationController
  layout 'panel'
  before_filter :authenticate
  
  
  def admins_panel
    @question = Question.new
  end
  
  def post_question
    @question = Question.new(params[:question])
    @question.save
    redirect_to panel_path, notice: "Question has been saved."
  rescue ActiveRecord::relation
    flash[:error] = "Unable to save question"
    render :admins_panel
  end
  
  
  protected
  
  USERNAME = "datingscene"
  PASSWORD = "loveboat"
  
  
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == USERNAME && password == PASSWORD
      end
    end
  
end
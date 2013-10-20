class Admin::QuestionsController < AdminController
  
  def index
    @questions = Question.all
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to new_admin_question_path, notice: "Question has been saved."
    else
      flash[:error] = "Unable to save question"
      render :new
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to admin_questions_path, notice: 'done'
  end
  
  protected
  
  def question_params
    params.require(:question).permit(:text, :category, :video)
  end
  
end
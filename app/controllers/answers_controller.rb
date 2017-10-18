class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:destroy]
  before_action :authorize_user!, except: [:create]


  def create
    @answer = @question.answers.build(answer_params)
    # ð
    # @answer = Answer.new(answer_params)
    # @answer.question = @question
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(@question)
    else
      # We can also give render a string as an argument. When doing so,
      # we can provide the path beginning from `/views` to the template we
      # want to render. ð will render `show.html.erb` from `/views/questions`.
      @answers = @question.answers.order(created_at: :desc)
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private
  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def authorize_user!
    unless can?(:manage, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end

  ##### END #######
end
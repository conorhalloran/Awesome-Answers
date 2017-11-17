class SurveyQuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @survey_question = SurveyQuestion.new
    3.times { @survey_question.survey_answers.build }
  end

  def create
    @survey_question = SurveyQuestion.new survey_question_params
    @survey_question.user = current_user
    if @survey_question.save
      redirect_to survey_questions_path, notice: 'Question created'
    else
      render :new
    end
  end

  def index
    @survey_questions = SurveyQuestion.order(created_at: :desc)
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:body,
                                            survey_answers_attributes:
                                              [:body, :id, :_destroy])
  end
end
class QuestionsController < ApplicationController
  # 'before_action' are executed in the order in which they appear. Make sure that any action depends on anthor appears after that action. 
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :show, :new, :create]

  # All public methods in controllers are referred to as
  # actions.
  def new
    # Using the render method is not necessary if
    # there is a view in `views/questions` with the
    # same name as the action `new`
    @question = Question.new
  end

  def create
    # render json: params
    # return
    # ð Use `render` with the `json:` argument to display
    # any object in the browser as the response. Similar to
    # `response.send` from Express. Very useful for debugging.
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      redirect_to question_path(@question)
      # redirect_to @question #ð when given a model instance, shortcut for ð
    else
      render :new
      # render can take a symbol as argument which should be named after
      # an action. It'll render the template for that action instead.
    end
  end

  def show
    # The following ð is repeated in many actions. All actions that
    # refer to an individual question. We'll use a callback with `before_action`
    # to call a method, `find_question`, that finds the question and assigns
    # it to `@question` only for the actions that use an individual question.
    # (e.g. show, edit, update, destroy)
    # You can find `before_action` at the top of this file.
    # @question = Question.find params[:id]
    # @answers = Answer.where(question_id: @question.id)
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
    @like = @question.likes.find_by_user_id current_user

  end

  def edit
    # @question = Question.find params[:id]
  end

  def index
    @questions = Question.order(created_at: :desc)
  end

  def update
    return head :unauthorized unless can?(:update, @question)
    # 'head' is a method similar to 'render' or 'redirect_to'. It finalizess the response. However, it will not add content to the response. It will simply set the HTTP status of the response. (e.g head :unauthorized sets the status code to 401) 
    if @question.update question_params
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  

  private

  def question_params
    # With this method, we will extract the parameters related to
    # question from the `params` object. And, we'll only permit
    # fields of our choice. In this case, we specifically permit
    # the fields we allow the user to edit in the new_question form.
    params.require(:question).permit(:title, :body, {tag_ids: []})

    # The `params` object is available inside all controllers. It's
    # a "hash" that holds all URL params, all fields from the form and
    # all query params. It's as if we merged `request.query`, `request.params`
    # and `request.body` from Express into one object.
  end

  def find_question
    @question = Question.find params[:id]
  end

  # Remember that if a 'before_action' callback does a 'render', 'redirect_to' pr 'head' (methods that terminate the response), it will stop the request from getting to the action.
  def authorize_user!
    # binding.pry
    unless can?(:crud, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path

    end
  end






  ##
end
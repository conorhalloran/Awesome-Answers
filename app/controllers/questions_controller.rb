class QuestionsController < ApplicationController
  # `before_action` are executed in the order in which they appear.
  # Make sure that any action that depends on another appears after that action.
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
    # 👆 Use `render` with the `json:` argument to display
    # any object in the browser as the response. Similar to
    # `response.send` from Express. Very useful for debugging.
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      @question.answer!
      QuestionRemindersJob.set(wait_until: 5.days.from_now).perform_later(@question.id)
      redirect_to question_path(@question)
      # redirect_to @question #👈 when given a model instance, shortcut for 👆
    else
      render :new
      # render can take a symbol as argument which should be named after
      # an action. It'll render the template for that action instead.
    end
  end

  def show
    # The following 👇 is repeated in many actions. All actions that
    # refer to an individual question. We'll use a callback with `before_action`
    # to call a method, `find_question`, that finds the question and assigns
    # it to `@question` only for the actions that use an individual question.
    # (e.g. show, edit, update, destroy)
    # You can find `before_action` at the top of this file.
    # @question = Question.find params[:id]
    # @answers = Answer.where(question_id: @question.id)
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
    # we're finding the like object for the user signed it to the question here
    # which is `@quesiton`. If the user has liked the question then @like should
    # refer to the row in the likes table with current_user id and @question id
    # If the user hasn't liked before then @like will be `nil`
    @like = @question.likes.find_by_user_id current_user

    # respond_to is a Rails built-in helper that enables us to send different
    # responses based on the format of the request from the client
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @question } # ActiveRecrod has to_json method
                                             # can can covert any of its objects
                                             # to JSON format
    end
  end

  def edit
    # @question = Question.find params[:id]
  end

  def index
    @questions = Question.where(aasm_state: [:published, :answered]).order(created_at: :desc)
  end

  def update
    return head :unauthorized unless can?(:update, @question)
    @question.slug = nil # this will force FriendlyId to regenerate the slug
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
    params.require(:question).permit(:title, :body, :image, {tag_ids: []})

    # The `params` object is available inside all controllers. It's
    # a "hash" that holds all URL params, all fields from the form and
    # all query params. It's as if we merged `request.query`, `request.params`
    # and `request.body` from Express into one object.
  end

  def find_question
    @question = Question.find params[:id]
  end

  # Remember that if a `before_action` callback does a `render`, `redirect_to` or
  # `head` (methods that terminate the response), it will stop the request from
  # getting to the action.
  def authorize_user!
    # binding.pry
    unless can?(:crud, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path

      # `head` is a method similar to `render` or `redirect_to`. It finalizes
      # the response. However, it will add content to the response. It will simply
      # set the HTTP status of the response. (e.g. head :unauthorized sets the
      # the status code to 401)
      # For a list of available status code symbols to use with `head` go to:
      # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
      # head :unauthorized
    end
  end







  ##
end
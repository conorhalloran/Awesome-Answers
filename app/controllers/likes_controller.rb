class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like = Like.new(user: current_user, question: question)
    if !can? :like, question
        head :unauthorized
    elsif like.save
      redirect_to question, notice: 'Thanks for liking!'
    else
      redirect_to question, alert: 'You already liked the question.'
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like
        like.destroy
        redirect_to like.question, notice: 'Like removed'
    else
        head :unauthorized
    end
  end

  private

end

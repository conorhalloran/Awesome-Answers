class VotesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_vote, only: [:destroy, :update]
    before_action :authorize!, only: [:destroy, :update]

    def create
        answer = Answer.find params[:answer_id]
        vote = Vote.new(is_up: params[:is_up],
                        user: current_user,
                        answer: answer
                    )
        if vote.save
        redirect_to answer.question, notice: 'Thanks for voting'
        else
        redirect_to answer.question, notice: 'can\'t vote!'
        end
    end

    def destroy
        @vote.destroy
        redirect_to @vote.question, notice: 'Vote removed'
    end

    def update
        @vote.update(is_up: params[:is_up])
        redirect_to @vote.question, notice: 'Vote Changed'
    end

    private

    def find_vote
        @vote = Vote.find params[:id]
    end

    def authorize!
        head :unauthorized unless can? :crud, @vote
    end

end

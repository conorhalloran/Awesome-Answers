class Api::V1::QuestionsController < Api::BaseController
    protect_from_forgery with: :null_session

    def index
        @questions = Question.order(created_at: :desc).limit(10)
        # render json: @questions 
    end

    def show
        question = Question.find params[:id]
        question.user = @api_user
        render json: question
    end

    def create
        question = Question.new question_params

        if question.save
            render json: question
        else
            render json: { errors: question.errors.full_messages }
        end
    end

    def update
        question = Question.find params[:id]
        if question.update question_params
            render json: {success: true}
        else
            render json: { errors: question.errors.full_messages }
        end
    end

    def destroy
        question = Question.find_by_id params[:id]
        if question
            question.destroy
            render json: {success: true}
        else
            render json: { errors: ['Question does\'t exist'] }
        end
    end

    private

    def question_params
        params.require(:question).permit(:title, :body, {tag_ids: []})
    end
end

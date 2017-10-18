class Admin::DashboardController < Admin::ApplicationController
    def index
        @stats = {
            question_count: Question.count,
            answer_count: Answer.count,
            user_count: User.count
        }
        @user = User.all
    end

end

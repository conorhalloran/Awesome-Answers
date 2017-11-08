class AnswersMailer < ApplicationMailer

    def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @question_owner = @question.user
    mail(to: 'conor_is_@hotmail.com', subject: 'You got a new answer!')
  end

end

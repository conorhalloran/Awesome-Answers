json.questions @questions do |question|
    json.id question.id
    json.title question.title
    json.created_at question.created_at.strftime('%d-%B-%Y')
    json.answer_count question.answers.count
    json.user do
        json.first_name question.user.first_name
        json.last_name question.user.last_name
    end
end
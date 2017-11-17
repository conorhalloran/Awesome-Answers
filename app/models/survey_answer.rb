class SurveyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :survey_question
end

class SurveyAnswer < ApplicationRecord
  belongs_to :survey_question

  validates :body, presence: true
end

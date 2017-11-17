class SurveyQuestion < ApplicationRecord
  belongs_to :user
  has_many :survey_answers, dependent: :destroy
  validates :body, presence: true
end

class SurveyQuestion < ApplicationRecord
  belongs_to :user
  has_many :survey_answers, dependent: :destroy
  accepts_nested_attributes_for :survey_answers
  validates :body, presence: true
end

class SurveyQuestion < ApplicationRecord
  belongs_to :user
  has_many :survey_answers, dependent: :destroy
  # reject_if: :all_blank -> this will not create an associated record with survey_question if all the attributes for the `survey_answer` are blank
  accepts_nested_attributes_for :survey_answers, reject_if: :all_blank
  validates :body, presence: true
end
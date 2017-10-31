class Like < ApplicationRecord
  belongs_to :question
  belongs_to :user

  # When we use 'scope' with uniqueness validation then we ensure that we validate for a combination of fields. In this case we make sure that the combination of question_id/user_id is unique
  validates :question_id, uniqueness: { scope: :user_id}
end

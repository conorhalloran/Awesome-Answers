class Answer < ApplicationRecord
  # When the Answer model was generated, it was given the `question:references`
  # "column" (the actual column is `question_id`). This automatically
  # added the following line:
  belongs_to :user
  belongs_to :question
  
  #, optional: true
  # It tells Rails that in the association between Answer-Question, the answer
  # holds the foreign_key `question_id`.

  # `belongs_to` add a validation that enforces that the association must exist.
  # You can disable it by providing the option `optional: true`.

  # `belongs_to` also adds several instances methods for our convenience:
  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_question(attributes = {})
  # create_question!(attributes = {})
  # reload_question
  validates :body, presence: :true
end
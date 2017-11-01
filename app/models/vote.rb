class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  delegate :question, to: :answer
  # def question
  #   answer.question
  # end

  def self.up
    where(is_up: true)
  end

  def self.down
      where(is_up: false)
  end
end

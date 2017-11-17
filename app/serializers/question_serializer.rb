class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :body

  has_many :answers
  belongs_to :user

  def created_at
    object.created_at.strftime('%Y-%B-%d')
  end
end
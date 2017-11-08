class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at

  has_many :answers


  def created_at
    object.created_at.strftime('%Y-%B-%d')
  end
end

class Question < ApplicationRecord
  belongs_to :user
  # Like `belongs_to`, `has_many` tells Rails that Question is associated
  # to the Answer model.
  # The first argument is the associated model in lower and pluralized. It
  # is by convention the model that holds the foreign_key (i.e. `question_id`).
  has_many :answers, dependent: :nullify
  # `dependent: :destroy` will cause all associated answers to be destroyed
  # before a question is destroyed.

  # `dependent: :nullify` will cause all associated answers to no longer be
  # associated. In other words, their `question_id` field will be updated
  # with a `NULL` value.

  # `has_many` adds many convenience instance methods:
  # answers
  # answers<<(object, ...)
  # answers.delete(object, ...)
  # answers.destroy(object, ...)
  # answers=(objects)
  # answers_ids
  # answers_ids=(ids)
  # answers.clear
  # answers.empty?
  # answers.size
  # answers.find(...)
  # answers.where(...)
  # answers.exists?(...)
  # answers.build(attributes = {}, ...)
  # answers.create(attributes = {})
  # answers.create!(attributes = {})
  # answers.reload


  # We can define validations here. They'll be checked before a model is saved to
  # the database. If any of the rules fail, ActiveRecord will prevent saving the
  # model and will put an error message on the instance.
  # You can check if a model instance passes all validations with the
  # instance method `.valid?`

  validates(:title, {
      presence: {message: 'must be provided'},
      uniqueness: true
    })

  validates(:body, {
      presence: true,
      length: {minimum: 5, maximum: 2000}
    })

  validates(:view_count, numericality: {
      greater_than_or_equal_to: 0
    })

  validate :no_monkey

  after_initialize :set_defaults
  before_validation :titleize_title

  scope :recent, -> (count) { order(created_at: :desc).limit(count) }
  # ð handy ActiveRecord method to generate scope methods like ð
  # def self.recent(count)
  #   order(created_at: :desc).limit(count)
  # end

  private
  def set_defaults
    # You can read any attribute inside a model's class by just referring to it
    # by name, but you must prefix it with `self.` if you want to write to it.
    # self.view_count = view_count || 0
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize if title.present?
  end

  def no_monkey
    if title.present? && title.downcase.include?('monkey')
      errors.add(:title, 'should not have a monkey! ð«ð')
    end
  end
end
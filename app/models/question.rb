class Question < ApplicationRecord
  belongs_to :user
  # Like `belongs_to`, `has_many` tells Rails that Question is associated
  # to the Answer model.
  # The first argument is the associated model in lower and pluralized. It
  # is by convention the model that holds the foreign_key (i.e. `question_id`).
  has_many :answers, dependent: :nullify
  has_many :likes, dependent: :destroy
  # has_many :users, through: :likes

  # we prefer using the line 👇 instead of the one 👆 because it's more readable and less
  # confusing especially that we have `belongs_to :user` association at the top
  has_many :likers, through: :likes, source: :user

  # to establish a many-to-many association we decompose the assocition into two one-to-many associtions and then establish the many-to-many links using Rails `through` feature.
  
  # Note that when you use has_many..through make sure that the model that you're using with the `through` option must have an assocition `belongs_to` that matches what you provided with your `has_many`. 
  
  # For instance, if you put `has_many :users` then your `like` model must have `belongs_to :user`

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
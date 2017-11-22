class User < ApplicationRecord
    has_secure_password
    # `has_secure_password` is a built-in rails method that provides user authentication features for the model its called in: 
    # 0.) It will add to attribute accessor for the fields, password & password_confirmation 
    # 1.) It will automatically add a presence validator for the password field.
    # 2.) When given a password, it will hash it and save as password_digest in the database using the library bcrypt.
    # 3.) It will add the instance 'authenticate' used to verify a password of a user. If the given password is correct, it will return the user instance. Otherwise, it will return 'false'.

    extend FriendlyId
    friendly_id :slug_candidates, use: [:slugged, :history, :finders]

    def slug_candidates
        [
            [:first_name, :last_name, :city, :street]
        ]
    end

    
    has_many :answers, dependent: :nullify
    has_many :questions, dependent: :nullify
    
    has_many :likes, dependent: :destroy
    has_many :liked_questions, through: :likes, source: :question

    has_many :votes, dependent: :destroy
    has_many :voted_answers, through: :votes, source: :answer

    geocoded_by :full_street_address   # can also be an IP address
    after_validation :geocode          # auto-fetch coordinates

    # if your `has_many...through` is using a non-standard name, in this case we're using `liked_questions` instead of `questions` then we have to provide a `source` option which should match the `belongs_to` association name in the join model which is `like` in our case

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    # The `validates` option `format:` takes a Regular Expression which is way to verify that string is formatted in certain way. The regular expression above tests that our emails begin with alpha numeric characters, have a @ in the middle which is followed by a word, a dot, then another word.
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true

    before_create :generate_api_key

    def full_name
        "#{first_name} #{last_name}"
    end

    def full_street_address
        "#{street} #{city} #{province} #{country} #{postal_code}"
    end

    private

    def generate_api_key
        loop do
            self.api_key = SecureRandom.urlsafe_base64(64)
            break unless User.exists?(api_key: self.api_key)
        end
    end
end

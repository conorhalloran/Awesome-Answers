# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Answer.destroy_all
Question.destroy_all
User.destroy_all
Tag.destroy_all

PASSWORD = 'vladsucks'

super_user = User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
  )

10.times.each do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
)
end

users = User.all

200.times.each do
    Question.create(
        title: Faker::LordOfTheRings.character, 
        body: Faker::MostInterestingManInTheWorld.quote,
        view_count: rand(1...1000000),
        user: users.sample
    )
end

30.times do 
    Tag.create(name: Faker::Space.galaxy)
end

tags = Tag.all

questions = Question.all
    
questions.each do |question|
  rand(0..5).times.each do
    answer = Answer.create(
      body: Faker::TheFreshPrinceOfBelAir.quote,
      question: question,
      user: users.sample
    )
    users.shuffle.slice(0..rand(10)).each do |user|
      Vote.create(user: user, answer: answer, is_up: [true, false].sample)
    end
  end
  question.likers = users.shuffle.slice(0..rand(10))
  question.tags = tags.shuffle.slice(0..rand(5))
end


answers = Answer.all

puts Cowsay.say("Created #{users.count} questions", :tux)
puts Cowsay.say("Created #{questions.count} questions", :ghostbusters)
puts Cowsay.say("Created #{answers.count} answers", :moose)
puts Cowsay.say("Created #{tags.count} tags", :tux)
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"
require 'faraday'
require 'json'

BASE_URL = 'http://localhost:3000'
API_KEY = 'axgV1SHtk0EMjFjxcs3ZLwGjLWEb-2JlvDOHAsCNNhqIZ8cI3qEYvUR4DaFLJE9fUFVWBpidw06nVwvqxvhHSw'

conn = Faraday.new url: BASE_URL

response = conn.get do |req|
  req.url '/api/v1/questions'
  req.headers['API_KEY'] = API_KEY
end

data = JSON.parse(response.body)
data["questions"].each do |question|
  puts "#{question['id']} - #{question['title']}"
end

def update(conn)
  print 'Select a question id: '
  id = gets.chomp
  print 'Enter a new title: '
  title = gets.chomp
  print 'Enter a new body: '
  body = gets.chomp

  params = { question: { title: title, body: body } }

  response = conn.patch do |req|
    req.url "/api/v1/questions/#{id}"
    req.headers['API_KEY'] = API_KEY
    req.params = params
  end
  data = JSON.parse(response.body)
  if data['errors']
    puts "Something went wrong: #{data['errors']}"
  else
    puts 'Update was successful'
  end
end

def destroy(conn)
  print 'Select a question id '
  id = gets.chomp

  response = conn.delete do |req|
    req.url "/api/v1/questions/#{id}"
    req.headers['API_KEY'] = API_KEY
  end
  data = JSON.parse(response.body)
  if data['errors']
    puts "Error happend: #{data['errors']}"
  else
    puts 'Delete was successful'
  end

end

def show(conn)
  print 'Select a question id '
  id = gets.chomp

  response = conn.get do |req|
    req.url "/api/v1/questions/#{id}"
    req.headers['API_KEY'] = API_KEY
  end

  data = JSON.parse(response.body)

  puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'
  puts data["id"]
  puts data["title"]
  puts data["created_at"]
  puts '---- ANSWERS'
  data["answers"].each do |answer|
    puts answer['body']
    puts '--------------------'
  end
  puts '>>>>>>>>>>>>> QUESTION DETAILS >>>>>>>>>>>>>>>>>>'
end

loop do
  puts 'Enter one of those commands: s (show), u (update), d (delete) or e (exit)'
  print 'The command: '
  user_input = gets.chomp
  if user_input == 'e'
    break
  elsif user_input == 's'
    show(conn)
  elsif user_input == 'u'
    update(conn)
  elsif user_input == 'd'
    destroy(conn)
  else
    puts 'Command not recognized'
  end
end
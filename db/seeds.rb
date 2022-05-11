require 'faker'

user_return = []

for x in 1..50 do
  temp_name = Faker::Name.name
  username = temp_name.split(" ").join("").downcase
  email = "#{username}@gmail.com"
  user_return.push({
    name: temp_name,
    email: email,
    username: username,
    member: Faker::Boolean.boolean
  })
end

users = User.create(user_return)

puts "Created #{User.count} users"
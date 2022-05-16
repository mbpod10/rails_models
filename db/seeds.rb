require 'faker'

user_return = []

for x in 1..10 do
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


25.times do
  Post.create(
    user_id: rand(1..User.count),
    title:  Faker::Hipster.sentence(word_count: 3).titleize,
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Post.count} Posts"

Tag.create([
    {tag_name: 'Nature'},
    {tag_name: 'School'},
    {tag_name: 'Nursing'},
    {tag_name: 'Education'},
    {tag_name: 'Handy'},
    {tag_name: 'Sports'},
    {tag_name: 'Business'},
    {tag_name: 'Tech'},
    {tag_name: 'Trees'},
    {tag_name: 'Hobby'},
])
puts "Created #{Tag.count} Tags"


50.times do
  Comment.create(
    user_id: rand(1..User.count),
    post_id: rand(1..Post.count),
    body: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
  )
end
puts "Created #{Comment.count} Comments"


100.times do
  PostTag.create(
    tag_id: rand(1..Tag.count),
    post_id: rand(1..Post.count)
  )
end
puts "Created #{PostTag.count} PostTags"
# $ bundle exec rake db:migrate:reset
# $ bundle exec rake db:seed

User.create!(username: "jason",
						 password: "password",
						 password_confirmation: "password",
						 admin: true)

99.times do |n|
  username = "example-#{n+1}"
  password = "password"
  User.create!(username:  username,
               password:              password,
               password_confirmation: password)
end

user = User.first
user.posts.create!(image_link:"http://i.imgur.com/QvUl7hy.jpg",
									 buy_link: "http://imgur.com/gallery/tZ88j")

user.posts.create!(image_link:"http://i.imgur.com/xROxFnS.jpg",
									 buy_link: "http://imgur.com/gallery/fcPkw")

user.posts.create!(image_link:"http://i.imgur.com/hJgwvDr.jpg",
									 buy_link: "http://imgur.com/gallery/hJgwvDr")

user.posts.create!(image_link:"http://i.imgur.com/1ey6VoX.jpg",
									 buy_link: "http://imgur.com/gallery/4rrbc")

user.posts.create!(image_link:"http://i.imgur.com/k6tw13L.jpg",
									 buy_link: "http://imgur.com/gallery/k6tw13L")
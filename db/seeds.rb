# $ bundle exec rake db:reset
# $ bundle exec rake db:seed

Category.create!(name: "Shirts",
									description: "the coolest shirts",
									slug: "shirts",
									is_default: true)
Category.create!(name: "Pants",
									description: "really cool pants",
									slug: "pants",
									is_default: true)
Category.create!(name: "Socks",
									description: "dope ass socks",
									slug: "socks",
									is_default: true)
Category.create!(name: "Watches",
									description: "to help tell time",
									slug: "watches",
									is_default: true)
Category.create!(name: "Scarves",
									description: "keep the neck warm",
									slug: "scarves")

case Rails.env
when "development"

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
										 buy_link: "http://imgur.com/gallery/tZ88j",
										 category_id: 2)

	user.posts.create!(image_link:"http://i.imgur.com/xROxFnS.jpg",
										 buy_link: "http://imgur.com/gallery/fcPkw",
										 category_id: 1)

	user.posts.create!(image_link:"http://i.imgur.com/hJgwvDr.jpg",
										 buy_link: "http://imgur.com/gallery/hJgwvDr",
										 category_id: 3)

	user.posts.create!(image_link:"http://i.imgur.com/1ey6VoX.jpg",
										 buy_link: "http://imgur.com/gallery/4rrbc",
										 category_id: 2)

	user.posts.create!(image_link:"http://i.imgur.com/k6tw13L.jpg",
										 buy_link: "http://imgur.com/gallery/k6tw13L",
										 category_id: 2)

when "production"

end
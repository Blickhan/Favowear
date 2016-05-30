task :reset_users_count => :environment do
	desc "updates the counter cache for users_count in categories"
	Category.find_each { |category| Category.reset_counters(category.id, :users)  }

	puts "user_counts have been updated"
end


task :reset_stylepoints => :environment do
	desc "updates the stylepoints for each user"
	User.find_each do |user|
		sum = 0
    user.posts.each do |post|
      sum += (post.get_upvotes.size - post.get_downvotes.size)
    end
    user.update_attribute(:stylepoints, sum)
	end

	puts "user.stylepoints have been updated"
end


task :follow_defaults => :environment do
	desc "follows each default category for each user"
	User.find_each do |user|
		Category.where(is_default: true).each do |category|
      user.follow(category)
    end
	end

	puts "users are now following defaults"
end
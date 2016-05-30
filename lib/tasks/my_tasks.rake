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
    	# could probably use post.cached_votes_score but 
    	# (post.get_upvotes.size - post.get_downvotes.size) works as well
      sum += (post.get_upvotes.size - post.get_downvotes.size)
      # account for the post.user's vote and remove it
      if user.voted_up_on? post
      	sum -= 1
      elsif user.voted_down_on? post
      	sum += 1
      end
    end
    user.update_attribute(:stylepoints, sum)
	end

	puts "user.stylepoints have been updated"
end


task :follow_defaults => :environment do
	desc "follows each default category for each user"
	User.find_each do |user|
		Category.where(is_default: true).each do |category|
      if !user.following?(category)
      	user.follow(category)
    	end
    end
	end

	puts "users are now following defaults"
end
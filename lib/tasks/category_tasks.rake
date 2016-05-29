task :reset_users_count => :environment do
	desc "updates the counter cache for users_count in categories"
	Category.find_each { |category| Category.reset_counters(category.id, :users)  }

	puts "user_counts have been updated"
end
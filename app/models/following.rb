class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, :counter_cache => :users_count
  validates :user_id, presence: true
  validates :category_id, presence: true
end

class Vote < ApplicationRecord
  belongs_to :feedback, counter_cache: :upvotes_count
  belongs_to :user

  validates :feedback_id, uniqueness: { scope: %i[feedback_id user_id] }
end

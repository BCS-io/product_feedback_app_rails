class AddUpvotesCounterCacheToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :upvotes_count, :integer, null: false, default: 0
    Feedback.find_each { |feedback| Feedback.reset_counters(feedback.id, :upvotes) }
  end
end

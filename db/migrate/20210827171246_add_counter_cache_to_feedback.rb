class AddCounterCacheToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :comments_count, :integer, default: 0
    Feedback.find_each { |feedback| Feedback.reset_counters(feedback.id, :comments) }
  end
end

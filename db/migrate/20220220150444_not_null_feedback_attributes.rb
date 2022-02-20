class NotNullFeedbackAttributes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :feedbacks, :category, false
    change_column_null :feedbacks, :status, false
  end
end

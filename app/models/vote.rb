class Vote < ApplicationRecord
  belongs_to :feedback
  belongs_to :user

  validates :feedback_id, uniqueness: { scope: %i[feedback_id user_id] }
end

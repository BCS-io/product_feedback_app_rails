class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :parent, optional: true, class_name: "Comment"

  MIN_LENGTH = 3
  MAX_LENGTH = 250
  validates :content, presence: true
  validates :content, length: { minimum: MIN_LENGTH, maximum: MAX_LENGTH }

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end
end

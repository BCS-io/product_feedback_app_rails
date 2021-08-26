# frozen_string_literal: true

class NewCommentComponent < ViewComponent::Base
  def initialize(commentable:, parent_id: nil, klass: nil, reply_target: nil)
    @commentable = commentable
    @parent_id = parent_id
    @klass = klass
    @reply_target = reply_target
  end
end

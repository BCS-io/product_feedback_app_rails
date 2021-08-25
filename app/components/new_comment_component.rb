# frozen_string_literal: true

class NewCommentComponent < ViewComponent::Base
  def initialize(commentable:, parent_id: nil, klass: nil)
    @commentable = commentable
    @parent_id = parent_id
    @klass = klass
  end
end

# frozen_string_literal: true

class NewCommentComponent < ViewComponent::Base
  def initialize(commentable:)
    @commentable = commentable
  end
end

# frozen_string_literal: true

class CommentComponent < ViewComponent::Base
  def initialize(comment:, comment_iteration:)
    @comment = comment
    @iteration = comment_iteration
  end
end

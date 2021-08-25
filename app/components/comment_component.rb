# frozen_string_literal: true

class CommentComponent < ViewComponent::Base
  def initialize(comment:, comment_iteration:, max_nesting: 8, nesting: 0)
    @comment = comment
    @iteration = comment_iteration
    @max_nesting = max_nesting
    @nesting = nesting
  end

  def orphan?
    @comment.parent_id.nil?
  end

  #
  # Untested
  #
  def comment_reply_id
    if @nesting < @max_nesting
      # reply is set to current comment
      @comment.id
    else
      # reply is set to parent comment
      # **stopping nesting**
      @comment.parent_id
    end
  end

  def debug_nesting_level(offset: 0)
    "test-nesting-level-#{@nesting + offset}"
  end
end

# frozen_string_literal: true

class FeedbackViewComponent < ViewComponent::Base
  def initialize(feedback:, current_user:, text_limit: true)
    @feedback = feedback
    @current_user = current_user
    @text_limit = text_limit
  end
end

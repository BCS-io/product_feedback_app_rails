# frozen_string_literal: true

class FeedbackViewComponent < ViewComponent::Base
  def initialize(feedback:)
    @feedback = feedback
  end
end

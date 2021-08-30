# frozen_string_literal: true

class RoadmapItemComponent < ViewComponent::Base
  def initialize(feedback:, current_user:)
    @feedback = feedback
    @current_user = current_user
  end
end

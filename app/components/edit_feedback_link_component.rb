# frozen_string_literal: true

class EditFeedbackLinkComponent < ViewComponent::Base
  include Pundit
  attr_reader :current_user

  def initialize(feedback:, current_user:)
    @feedback = feedback
    @current_user = current_user
  end
end

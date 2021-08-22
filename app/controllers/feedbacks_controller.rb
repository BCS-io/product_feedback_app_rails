class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    authorize @feedback
  end
end

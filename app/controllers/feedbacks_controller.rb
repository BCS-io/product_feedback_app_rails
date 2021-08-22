class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    authorize @feedback
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    @feedback.status = "suggestion" unless current_user.staff_role?
    if @feedback.save
      redirect_to root_path, notice: "Feedback was successfully created"
    else
      render :new
    end
    authorize @feedback
  end

  private

  def feedback_params
    params.require(:feedback).permit(:title, :category, :status, :description)
  end
end

class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def new
    @feedback = Feedback.new
    store_back_location!
    authorize @feedback
  end

  def show
    @feedback = Feedback.find(params[:id])
    authorize @feedback
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    @feedback.status = "suggestion" unless current_user.staff_role?
    if @feedback.save
      redirect_to retrieve_back_location_or_default, notice: "Feedback was successfully created"
    else
      render :new
    end
    authorize @feedback
  end

  def edit
    @feedback = Feedback.find(params[:id])
    store_back_location!
    authorize @feedback
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update(feedback_params)
      redirect_to retrieve_back_location_or_default, notice: "Feedback was successfully updated"
    else
      render :edit
    end
    authorize @feedback
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    redirect_to retrieve_last_index_page_or_default,
                notice: "Feedback was successfully destroyed"
    authorize @feedback
  end

  private

  def feedback_params
    params.require(:feedback).permit(:title, :category, :status, :description)
  end
end

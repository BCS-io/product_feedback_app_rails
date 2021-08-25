module Feedbacks
  class CommentsController < CommentsController
    before_action :set_commentable

    protected

    def return_path
      suggestion_path(@commentable)
    end

    private

    def set_commentable
      @commentable = Feedback.find(params[:feedback_id])
    end
  end
end

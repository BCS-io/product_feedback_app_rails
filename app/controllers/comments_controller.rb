class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to return_path
    else
      redirect_to return_path, alert: "Something went wrong"
    end
    # TODO: how to authorize comments?
    authorize @commentable
  end

  private

  def return_path
    @commentable
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end

class VotesController < ApplicationController
  def create
    result = Votes::VotesCreate.new.votes_create(current_user: current_user,
                                                 feedback_id: params[:feedback])
    @vote = result.vote # @vote used in js
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
    authorize Vote
  end

  def destroy
    result = Votes::VotesDestroy.new.votes_destroy(vote_id: params[:id])
    @feedback = result.feedback # @feedback used in js

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
    authorize Vote
  end
end

class SuggestionsController < ApplicationController
  def index
    @results = Suggestions::SuggestionsIndex.new.suggestions_index(category: params[:category])
    authorize @results.feedbacks
  end

  def show
    @feedback = Feedback.find(params[:id])
    authorize @feedback
  end
end

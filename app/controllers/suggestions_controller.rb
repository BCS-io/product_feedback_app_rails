class SuggestionsController < ApplicationController
  def index
    @results = Suggestions::SuggestionsIndex.new.suggestions_index(category: params[:category])
    authorize @results.feedbacks
  end
end

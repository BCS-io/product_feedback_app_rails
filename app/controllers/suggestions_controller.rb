class SuggestionsController < ApplicationController
  def index
    @results = Suggestions::SuggestionsIndex.new.suggestions_index
    authorize @results.feedbacks
  end
end

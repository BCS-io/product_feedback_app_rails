class SuggestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @results = Suggestions::SuggestionsIndex.new.suggestions_index(category: params[:category],
                                                                   sort: params[:column_sort])
    authorize @results.feedbacks
  end
end

class SuggestionsController < ApplicationController
  layout "homepage"
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @results = Suggestions::SuggestionsIndex.new.suggestions_index(category: params[:category],
                                                                   sort: params[:column_sort])
    store_last_index_page
    authorize @results.feedbacks
  end
end

module SuggestionHelper
  def current_page_params
    request.params.slice("status", "category", "column_sort")
  end
end

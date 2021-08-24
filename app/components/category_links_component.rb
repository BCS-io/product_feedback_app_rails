# frozen_string_literal: true

class CategoryLinksComponent < ViewComponent::Base
  include SuggestionHelper
  def initialize(category:)
    @category = category
  end
end

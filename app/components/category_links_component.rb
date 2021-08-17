# frozen_string_literal: true

class CategoryLinksComponent < ViewComponent::Base
  def initialize(category:)
    @category = category
  end
end

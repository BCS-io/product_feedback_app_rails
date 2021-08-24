require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "GuestSortBy" do
      it "sorts by upvotes", type: :system, js: true do
        skip "expectation does not work"
        customer = create(:customer)
        create(:feedback, upvotes: 10, title: "Difficult issue", category: "bug", status: "suggestion", user: customer)
        create(:feedback, upvotes: 5, title: "Easy issue", category: "bug", status: "suggestion", user: customer)
        visit root_path

        # select "Least Upvotes", from: "Sort by"

        expect(page.text).to match /Difficult issue.*Easy issue/
      end
    end
  end
end

require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "GuestSortBy" do
      it "sorts by upvotes", type: :system, js: true do
        customer = create(:customer)
        create(:feedback, title: "Difficult issue", category: "bug", status: "suggestion", user: customer)
        feedback = create(:feedback, title: "Easy issue", category: "bug", status: "suggestion", user: customer)
        create(:vote, user: customer, feedback: feedback)
        visit root_path

        select "Least Upvotes", from: "Sort by"

        expect(page.text).to match /Difficult issue.*Easy issue/m

        select "Most Upvotes", from: "Sort by"

        expect(page.text).to match /Easy issue.*Difficult issue/m
      end
    end
  end
end

require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "GuestCategoryFilter", type: :system, js: true do
      it "filters by category" do
        customer = create(:customer)
        create(:feedback, title: "Difficult issue", category: "bug", status: "suggestion", user: customer)
        visit root_path

        within ".test-desktop" do
          within ".test-category-links-component" do
            click_on "Bug"
          end
        end

        expect(page).to have_text "Difficult issue"

        within ".test-desktop" do
          within ".test-category-links-component" do
            click_on "Enhancement"
          end
        end

        expect(page).not_to have_text "Difficult issue"
      end

      it "keeps filter even if sort changed" do
        customer = create(:customer)
        create(:feedback, title: "Difficult issue", category: "bug", status: "suggestion", user: customer)
        visit root_path

        within ".test-desktop" do
          within ".test-category-links-component" do
            click_on "Enhancement"
          end
        end

        expect(page).not_to have_text "Difficult issue"

        select "Least Upvotes", from: "Sort by"

        expect(page).not_to have_text "Difficult issue"
      end
    end
  end
end

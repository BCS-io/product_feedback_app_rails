require "rails_helper"

module Feedbacks
  module Show
    RSpec.describe "CustomerShow", type: :system do
      it "can vote" do
        customer = create(:customer)
        feedback = create(:feedback,
                          status: "suggestion",
                          title: "Visit the show page",
                          user: create(:staff))
        create(:vote, feedback: feedback, user: create(:staff))
        visit root_path
        sign_in customer

        click_on "Visit the show page"

        within ".test-feedback-view-component" do
          click_on "1"

          expect(page).to have_text "2"

          click_on "2"

          expect(page).to have_text "1"
        end
      end
    end
  end
end

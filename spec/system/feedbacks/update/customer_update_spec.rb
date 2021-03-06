require "rails_helper"

module Feedbacks
  module Update
    RSpec.describe "CustomerUpdate", type: :system do
      it "return visit when clicking back" do
        customer = create(:customer)
        feedback = create(:feedback, title: "Offer dark version",
                                     status: "suggestion",
                                     user: customer)
        sign_in customer
        visit feedback_path(feedback)

        click_link "Edit Feedback"

        click_link "Go Back"

        expect(page).to have_link nil, text: "Edit Feedback"
      end

      it "updates feedback" do
        customer = create(:customer)
        create(:feedback, title: "Offer dark version",
                          status: "suggestion",
                          user: customer)
        sign_in customer
        visit root_path

        click_link "Offer dark version"

        click_link "Edit Feedback"

        fill_in "Title", with: "Different title"
        select "Enhancement", from: "Category"
        fill_in "Feedback Detail", with: "I would like to test this"

        click_button "Save Changes"

        expect(page).to have_text "Feedback was successfully updated"

        expect(page).to have_link "Edit Feedback"

        within ".test-feedback-view-component" do
          expect(page).to have_text "Different title"
          expect(page).to have_text "Enhancement"
          expect(page).to have_text "I would like to test this"
        end

        click_link "Go Back"

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "can cancel feedback" do
        customer = create(:customer)
        create(:feedback, title: "Offer dark version",
                          status: "live",
                          user: customer)
        sign_in customer
        visit roadmaps_path

        click_link "Offer dark version"

        click_link "Edit Feedback"

        fill_in "Title", with: ""

        click_link "Cancel"

        expect(page).to have_link nil, text: "Edit Feedback"
        expect(page).to have_selector "h3", text: "Offer dark version"

        click_link "Go Back"

        expect(page).to have_selector("h1", text: "Roadmap")
      end

      it "displays errors" do
        customer = create(:customer)
        create(:feedback, title: "Offer dark version",
                          status: "suggestion",
                          user: customer)
        sign_in customer
        visit root_path

        click_link "Offer dark version"

        click_link "Edit Feedback"

        fill_in "Title", with: ""

        click_button "Save Changes"

        expect(page).to have_text "can't be blank"
      end
    end
  end
end

require "rails_helper"

module Feedbacks
  module Destroy
    RSpec.describe "CustomerDestroy", type: :system do
      it "destroys feedback on suggestions" do
        customer = create(:customer)
        create(:feedback, title: "Offer dark version",
                          status: "suggestion",
                          user: customer)
        sign_in customer
        visit root_path
        click_link "Offer dark version"

        click_link "Edit Feedback"

        click_link "Destroy"

        expect(page).to have_text "Feedback was successfully destroyed"
        expect(page).to have_selector("h1", text: "Frontend Mentor")
        expect(page).not_to have_text "Offer dark version"
      end

      it "destroys feedback on roadmap" do
        customer = create(:customer)
        create(:feedback, title: "Offer dark version",
                          status: "live",
                          user: customer)
        sign_in customer
        visit roadmaps_path

        click_link "Offer dark version"

        click_link "Edit Feedback"

        click_link "Destroy"

        expect(page).to have_text "Feedback was successfully destroyed"
        expect(page).to have_selector("h1", text: "Roadmap")
        expect(page).not_to have_text "Offer dark version"
      end

      it "destroys feedback and returns to suggestions by default" do
        customer = create(:customer)
        feedback = create(:feedback, title: "Offer dark version",
                                     status: "suggestion",
                                     user: customer)
        sign_in customer
        visit feedback_path(feedback)

        click_link "Edit Feedback"

        click_link "Destroy"

        expect(page).to have_text "Feedback was successfully destroyed"
        expect(page).to have_selector("h1", text: "Frontend Mentor")
        expect(page).not_to have_text "Offer dark version"
      end
    end
  end
end

require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "CustomerIndex", type: :system do
      it "visits home page" do
        visit root_path

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "signs into and out of app" do
        user = create(:customer)
        visit root_path

        click_link class: "test-user-signed-out", match: :first # matches both the desktop nav and mobile nav

        fill_in "Login", with: user.email
        fill_in "Password", with: "password"
        click_on "Sign in"

        expect(page).to have_text "Signed in successfully."

        click_link class: "test-user-signed-in", match: :first

        expect(page).to have_text "Signed out successfully."
      end

      it "can vote", js: true do
        customer = create(:customer)
        feedback = create(:feedback, status: "suggestion", user: create(:staff))
        create(:vote, feedback: feedback, user: create(:staff))
        sign_in customer
        visit root_path

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

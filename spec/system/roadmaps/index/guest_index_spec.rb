require "rails_helper"

module Roadmaps
  module Index
    RSpec.describe "GuestIndex", type: :system do
      it "return visits roadmap page" do
        visit root_path

        click_link "view"

        expect(page).to have_selector("h1", text: "Roadmap")

        click_link "Go Back"

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "redirects to sign in if choose to add feedback" do
        visit roadmaps_path

        click_link "Add Feedback"

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end

      it "can visit the show page" do
        create(:feedback, status: "live", title: "Visit the show page", user: create(:staff))
        visit roadmaps_path

        click_on "Visit the show page"

        expect(page).to have_selector("span", text: "Edit Feedback")
        expect(page).to have_selector("h3", text: "Visit the show page")
      end

      it "redirects to sign in if click on vote", js: true do
        feedback = create(:feedback, status: "live", user: create(:staff))
        create(:vote, user: create(:staff), feedback: feedback)
        visit roadmaps_path

        click_link "1"

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end

      it "links profile button to sign in" do
        visit roadmaps_path

        click_link class: "test-user-signed-out", match: :first # matches both the desktop nav and mobile nav

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end
    end
  end
end

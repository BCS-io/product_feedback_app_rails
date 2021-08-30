require "rails_helper"

module Roadmaps
  module Index
    RSpec.describe "GuestIndex", type: :system do
      it "visits roadmap page" do
        visit root_path

        click_link "view"

        expect(page).to have_selector("h1", text: "Roadmap")
      end

      it "can return to homepage", js: true do
        visit roadmaps_path

        click_link "Go Back"

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "redirects to sign in if choose to add feedback" do
        visit roadmaps_path

        click_link "Add Feedback"

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end

      it "redirects to sign in if click on vote", js: true do
        skip "Vote is an Ajax request which devise requires some setup to work"
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

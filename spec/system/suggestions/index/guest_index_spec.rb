require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "GuestIndex", type: :system do
      it "visits suggestions page" do
        visit root_path

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "redirects voters to sign in", js: true do
        skip "Vote is an Ajax request which devise requires some setup to work"
        feedback = create(:feedback, status: "suggestion", user: create(:staff))
        create(:vote, feedback: feedback, user: create(:staff))
        visit root_path

        within ".test-feedback-view-component" do
          click_on "1"
        end

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end
    end
  end
end

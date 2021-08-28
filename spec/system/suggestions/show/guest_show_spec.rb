require "rails_helper"

module Suggestions
  module Show
    RSpec.describe "GuestShow", type: :system, js: true do
      it "visits suggestions page" do
        create(:feedback, status: "suggestion", user: create(:staff), title: "Joy")
        visit root_path

        click_on "Joy"

        expect(page).to have_selector("span", text: "Edit Feedback")
        expect(page).to have_selector("h3", text: "Joy")
      end

      it "is redirected via sign in when voting" do
        skip("Devise redirecting unauthorized require setup")
        feedback = create(:feedback, status: "suggestion", user: create(:staff), title: "Joy")
        create(:vote, feedback: feedback, user: create(:staff))
        visit root_path

        click_on "1"

        expect(page).to have_selector("h2", text: "Sign in to your account")
      end
    end
  end
end

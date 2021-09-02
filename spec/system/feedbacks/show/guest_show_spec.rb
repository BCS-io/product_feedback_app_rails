require "rails_helper"

module Feedbacks
  module Show
    RSpec.describe "GuestShow", type: :system, js: true do
      it "return back from show page to suggestions" do
        create(:feedback, status: "suggestion", user: create(:staff), title: "Joy")
        visit root_path

        click_on "Joy"

        expect(page).to have_selector("span", text: "Edit Feedback")
        expect(page).to have_selector("h3", text: "Joy")

        click_on "Go Back"

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end

      it "return back from show page to roadmaps", js: true do
        create(:feedback, status: "live",
                          user: create(:staff),
                          title: "Koi")
        visit roadmaps_path

        click_on "Koi"

        expect(page).to have_selector("span", text: "Edit Feedback")
        expect(page).to have_selector("h3", text: "Koi")

        click_on "Go Back"

        expect(page).to have_selector("h1", text: "Roadmap")
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

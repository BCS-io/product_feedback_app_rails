require "rails_helper"

module Roadmaps
  module Index
    RSpec.describe "CustomerIndex", type: :system do
      it "can add an upvote", js: true do
        feedback = create(:feedback, status: "live", user: create(:staff))
        create(:vote, user: create(:staff), feedback: feedback)
        sign_in create(:customer)
        visit roadmaps_path

        within ".test-roadmap-item-component" do
          click_on "1"

          expect(page).to have_text "2"

          click_on "2"

          expect(page).to have_text "1"
        end
      end
    end
  end
end

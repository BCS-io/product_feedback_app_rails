require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "GuestIndex", type: :system do
      it "visits suggestions page" do
        visit root_path

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end
    end
  end
end

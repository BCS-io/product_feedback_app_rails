require "rails_helper"

module Suggestions
  module Index
    RSpec.describe "CustomerIndex", type: :system do
      it "visits home page" do
        visit root_path

        expect(page).to have_selector("h1", text: "Suggestions")
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
    end
  end
end

require "rails_helper"

module Feedbacks
  module Create
    RSpec.describe "GuestCreate", type: :system do
      it "is redirected via sign in" do
        user = create(:customer)
        visit root_path

        click_link "Add Feedback"

        expect(page).to have_selector("h2", text: "Sign in to your account")

        fill_in "Email", with: user.email
        fill_in "Password", with: "password"
        click_on "Sign in"

        expect(page).to have_selector("h1", text: "Create New Feedback")
      end
    end
  end
end

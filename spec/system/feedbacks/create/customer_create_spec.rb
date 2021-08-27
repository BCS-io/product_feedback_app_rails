require "rails_helper"

module Feedbacks
  module Create
    RSpec.describe "CustomerCreate", type: :system do
      it "creates feedback" do
        customer = create(:customer)
        visit root_path
        sign_in customer

        click_link "Add Feedback"

        fill_in "Title", with: "New suggestions"
        select "Bug", from: "Category"
        fill_in "Feedback Detail", with: "I have a suggestion"

        click_button "Add Feedback"

        expect(page).to have_text "Feedback was successfully created"
        expect(page).to have_text "New suggestions"
      end

      it "displays errors" do
        customer = create(:customer)
        visit root_path
        sign_in customer

        click_link "Add Feedback"

        fill_in "Title", with: ""

        click_button "Add Feedback"

        expect(page).to have_text "can't be blank"
      end

      it "can cancel feedback" do
        customer = create(:customer)
        visit root_path
        sign_in customer

        click_link "Add Feedback"

        fill_in "Title", with: "New suggestions"

        click_link "Cancel"

        expect(page).to have_selector("h1", text: "Frontend Mentor")
      end
    end
  end
end

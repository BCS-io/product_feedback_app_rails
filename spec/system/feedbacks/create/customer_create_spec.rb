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
    end
  end
end

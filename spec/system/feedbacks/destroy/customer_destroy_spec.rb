require "rails_helper"

module Feedbacks
  module Destroy
    RSpec.describe "CustomerDestroy", type: :system, js: true do
      it "destroys feedback" do
        customer = create(:customer)
        feedback = create(:feedback, title: "Offer dark version",
                                     status: "suggestion",
                                     user: customer)
        sign_in customer
        visit edit_feedback_path(feedback)

        click_link "Destroy"

        expect(page).to have_text "Feedback was successfully destroyed"
      end
    end
  end
end

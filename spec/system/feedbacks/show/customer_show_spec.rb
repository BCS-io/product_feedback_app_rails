require "rails_helper"

module Feedbacks
  module Show
    RSpec.describe "CustomerShow", type: :system do
      it "can vote" do
        customer = create(:customer)
        feedback = create(:feedback,
                          status: "suggestion",
                          title: "Visit the show page",
                          user: create(:staff))
        create(:vote, feedback: feedback, user: create(:staff))
        sign_in customer
        visit root_path

        click_on "Visit the show page"

        within ".test-feedback-view-component" do
          click_on "1"

          expect(page).to have_text "2"

          click_on "2"

          expect(page).to have_text "1"
        end
      end

      it "can comment" do
        customer = create(:customer, :avatared)
        feedback = create(:feedback, title: "Visit the show page", user: create(:staff))
        sign_in customer
        visit feedback_path(feedback)

        within ".test-new-comment" do
          fill_in "Add Comment", with: "Hello world"
          click_on "Post Comment"
        end

        within ".test-show-comments" do
          expect(page).to have_text "Hello world"
        end
      end

      it "reply to comment", js: true do
        customer = create(:customer, :avatared)
        feedback = create(:feedback, user: create(:staff))
        create(:comment, content: "first message",
                         user: customer,
                         commentable: feedback)
        sign_in customer
        visit feedback_path(feedback)

        within ".test-show-comments" do
          click_on "Reply"
          fill_in "Add Comment", with: "second message"
          click_on "Post Comment"

          expect(page).to have_text "second message"
        end
      end

      it "can cause client side validation", js: true do
        customer = create(:customer, :avatared)
        feedback = create(:feedback, title: "Visit the show page", user: create(:staff))
        sign_in customer
        visit feedback_path(feedback)

        within ".test-new-comment" do
          fill_in "Add Comment", with: ""
          click_on "Post Comment"

          message = page.find("#comment_content").native.attribute("validationMessage")
          #
          # So selenium_chrome and selenium_chrome headless is giving out two
          # slightly different messages.
          #  - Please fill in this field
          #  - Please fill out this field
          # Not sure if it's the version of the
          # browser and if it might change with different versions. Either way
          # I'm covered for now
          #
          expect(message).to have_content /Please fill (out|in) this field/
        end

        # NOTE: Not got validation for too many characters as HTML 5 validation
        # is universal (> 99%) and it doesn't show any message it just stops the
        # user from entering any more.
        #
        # If the user bypasses the validation then it will render the
        # "new comment" again and ask them to fill in but this remains untested.
      end
    end
  end
end

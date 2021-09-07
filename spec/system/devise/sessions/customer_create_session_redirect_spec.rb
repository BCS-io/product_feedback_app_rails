require "rails_helper"

RSpec.describe "Devise::Sessions::CustomerCreateSessionRedirect", type: :system, js: true do
  it "redirects to the current page after sign in" do
    customer = create(:customer)
    visit roadmaps_path

    click_on "Add Feedback"

    fill_in "Login", with: customer.username
    fill_in "Password", with: "password"
    click_on "Sign in"

    expect(page).to have_selector("h1", text: "Create New Feedback")
  end

  it "redirects to the home page after sign in without previous page" do
    customer = create(:customer)
    visit new_user_session_path

    fill_in "Login", with: customer.username
    fill_in "Password", with: "password"
    click_on "Sign in"

    expect(page).to have_selector("h1", text: "Frontend Mentor")
  end

  context "when redirecting from homepage" do
    it "Goes back to homepage after navigating to add feedback" do
      customer = create(:customer)
      visit root_path

      click_on "Add Feedback"

      fill_in "Login", with: customer.username
      fill_in "Password", with: "password"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Create New Feedback")

      click_link "Go Back"

      expect(page).to have_selector("h1", text: "Frontend Mentor")
    end

    it "Cancels back to homepage after navigating to add feedback" do
      customer = create(:customer)
      visit root_path

      click_on "Add Feedback"

      fill_in "Login", with: customer.username
      fill_in "Password", with: "password"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Create New Feedback")

      click_link "Cancel"

      expect(page).to have_selector("h1", text: "Frontend Mentor")
    end
  end

  context "when redirecting from roadmaps" do
    it "Goes back to roadmaps after navigating to add feedback" do
      customer = create(:customer)
      visit roadmaps_path

      click_on "Add Feedback"

      fill_in "Login", with: customer.username
      fill_in "Password", with: "password"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Create New Feedback")

      click_link "Go Back"

      expect(page).to have_selector("h1", text: "Roadmap")
    end

    it "Cancels back to roadmaps after navigating to add feedback" do
      customer = create(:customer)
      visit roadmaps_path

      click_on "Add Feedback"

      fill_in "Login", with: customer.username
      fill_in "Password", with: "password"
      click_on "Sign in"

      expect(page).to have_selector("h1", text: "Create New Feedback")

      click_link "Cancel"

      expect(page).to have_selector("h1", text: "Roadmap")
    end
  end
end

require "rails_helper"

RSpec.describe "Devise::Sessions::CustomerCreateSession", type: :system do
  it "signs into the app with email" do
    customer = create(:customer)
    visit new_user_session_path

    fill_in "Login", with: customer.email
    fill_in "Password", with: "password"
    click_on "Sign in"

    expect(page).to have_text "Signed in successfully."
  end

  it "signs into the app with username" do
    customer = create(:customer)
    visit new_user_session_path

    fill_in "Login", with: customer.username
    fill_in "Password", with: "password"
    click_on "Sign in"

    expect(page).to have_text "Signed in successfully."
  end

  it "displays error if sign in fails" do
    create(:customer)
    visit new_user_session_path

    click_on "Sign in"

    expect(page).to have_text "Invalid Login or password."
  end
end

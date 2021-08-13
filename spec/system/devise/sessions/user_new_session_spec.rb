require "rails_helper"

RSpec.describe "Devise::Sessions::UserNewSession", type: :system do
  it "signs into the app" do
    user = create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Sign in"

    expect(page).to have_text "Signed in successfully."
  end

  it "displays error if sign in fails" do
    create(:user)
    visit new_user_session_path

    click_on "Sign in"

    expect(page).to have_text "Invalid Email or password."
  end
end

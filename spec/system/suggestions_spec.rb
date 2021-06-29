require "rails_helper"

RSpec.describe "Suggestions", type: :system do
  it "visits suggestions page" do
    visit root_path

    expect(page).to have_selector("h1", text: "Suggestions")
  end
end

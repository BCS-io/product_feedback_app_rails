require "rails_helper"

RSpec.describe UserLoginComponent, type: :component do
  it "renders profile if signed in" do
    render_inline(UserLoginComponent.new(current_user: build(:user, username: "badger"), user_signed_in: true))

    expect(rendered_component).to have_link("b")
  end

  it "renders generic user if signed out " do
    render_inline(UserLoginComponent.new(current_user: build(:user), user_signed_in: false))

    expect(rendered_component).to have_link(nil, href: "/users/sign_in")
  end
end

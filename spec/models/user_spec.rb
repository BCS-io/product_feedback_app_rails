require "rails_helper"

RSpec.describe User, type: :model do
  it "has roles" do
    expect(User.new).to define_enum_for(:role)
  end
end

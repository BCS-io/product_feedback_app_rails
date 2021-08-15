require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    # NOTE: Devise validates devise set variables like email
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:username) }
  end

  describe "#full_name" do
    it "returns compound name" do
      user = build(:user, first_name: "John", last_name: "Smith")

      expect(user.full_name).to eq "John Smith"
    end
  end

  it "has roles" do
    expect(User.new).to define_enum_for(:role)
  end
end

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

  describe "#voted?()" do
    it "returns true when voted" do
      user = create(:user)
      feedback = create(:feedback, user: user)
      create(:vote, user: user, feedback: feedback)

      expect(user.voted?(feedback_id: feedback.id)).to be true
    end

    it "returns false when not voted" do
      user = create(:user)
      feedback = create(:feedback, user: user)

      expect(user.voted?(feedback_id: feedback.id)).to be false
    end
  end

  describe "#voted" do
    it "returns vote when available" do
      user = create(:user)
      feedback = create(:feedback, user: user)
      vote = create(:vote, user: user, feedback: feedback)

      expect(user.vote(feedback_id: feedback.id)).to eq vote
    end

    it "returns noting when not available" do
      user = create(:user)
      feedback = create(:feedback, user: user)

      expect(user.vote(feedback_id: feedback.id)).to eq nil
    end
  end
end

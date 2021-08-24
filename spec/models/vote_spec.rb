require "rails_helper"

RSpec.describe Vote, type: :model do
  describe "#valid?" do
    it "is valid if a unique vote" do
      customer1 = create(:customer)
      feedback1 = create(:feedback, user: customer1)

      vote2 = Vote.new(feedback: feedback1, user: customer1)

      expect(vote2).to be_valid
    end

    it "is invalid if a repeated vote" do
      customer1 = create(:customer)
      feedback1 = create(:feedback, user: customer1)
      create(:vote, feedback: feedback1, user: customer1)

      vote2 = Vote.new(feedback: feedback1, user: customer1)

      expect(vote2).not_to be_valid
    end
  end
end

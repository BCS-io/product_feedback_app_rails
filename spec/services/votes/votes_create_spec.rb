require "rails_helper"

module Votes
  RSpec.describe VotesCreate, type: :service do
    it "adds a vote if none present" do
      voter = create(:customer)
      customer = create(:customer)
      feedback = create(:feedback, status: "suggestion", user: customer)

      result = VotesCreate.new.votes_create(current_user: voter, feedback_id: feedback.id)

      expect(result).to be_created
      expect(result.vote.feedback).to eq feedback
    end

    it "does not add a vote if already present for voter" do
      voter = create(:customer)
      customer = create(:customer)
      feedback = create(:feedback, status: "suggestion", user: customer)
      vote = create(:vote, user: voter, feedback: feedback)

      result = VotesCreate.new.votes_create(current_user: voter, feedback_id: feedback.id)

      expect(result).not_to be_created
      expect(result.vote).to eq vote
    end
  end
end

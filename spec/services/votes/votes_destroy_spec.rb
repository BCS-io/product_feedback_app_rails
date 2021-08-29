require "rails_helper"

module Votes
  RSpec.describe VotesDestroy, type: :service do
    it "destroys a vote if present" do
      voter = create(:customer)
      customer = create(:customer)
      feedback = create(:feedback, status: "suggestion", user: customer)
      vote = create(:vote, user: voter, feedback: feedback)

      result = VotesDestroy.new.votes_destroy(vote_id: vote.id)

      expect(result).to be_destroyed
      expect(result.feedback.upvotes_count).to eq 0
    end

    it "does not destroy a vote if none present" do
      result = VotesDestroy.new.votes_destroy(vote_id: 8888)

      expect(result).not_to be_destroyed
      expect(result.vote).to be_nil
      expect(result.feedback).to be_nil
    end
  end
end

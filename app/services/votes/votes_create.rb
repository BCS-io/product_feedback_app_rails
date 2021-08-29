module Votes
  class VotesCreate
    def votes_create(current_user:, feedback_id:)
      vote = Vote.find_by(user: current_user, feedback_id: feedback_id)
      return Result.new(created: false, vote: vote) if vote

      vote = Vote.create(user: current_user, feedback_id: feedback_id)
      Result.new(created: vote.valid?, vote: vote)
    end

    class Result
      attr_reader :vote

      def initialize(created:, vote:)
        @created = created
        @vote = vote
      end

      def created?
        @created
      end
    end
  end
end

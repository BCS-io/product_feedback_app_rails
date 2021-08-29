module Votes
  class VotesDestroy
    def votes_destroy(vote_id:)
      vote = Vote.find_by(id: vote_id)
      return Result.new(destroyed: false, vote: vote, feedback: nil) unless vote

      feedback = vote.feedback
      vote.destroy
      feedback.reload

      Result.new(destroyed: true,
                 vote: vote,
                 feedback: feedback)
    end

    class Result
      attr_reader :vote, :feedback

      def initialize(destroyed:, vote:, feedback:)
        @destroyed = destroyed
        @vote = vote
        @feedback = feedback
      end

      def destroyed?
        @destroyed
      end
    end
  end
end

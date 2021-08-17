module Suggestions
  class SuggestionsIndex
    def suggestions_index(category: nil)
      roadmap = roadmap_status_zero_count.merge(roadmap_status_count)
      feedbacks = if category.present?
                    Feedback.where(status: "suggestion").where(category: category)
                  else
                    Feedback.where(status: "suggestion")
                  end

      Result.new(roadmap: roadmap, feedbacks: feedbacks)
    end

    class Result
      attr_reader :feedbacks, :roadmap

      def initialize(feedbacks:, roadmap:)
        @feedbacks = feedbacks
        @roadmap = roadmap
      end
    end

    private

    def roadmap_status_count
      Feedback.where(status: "planned")
              .or(Feedback.where(status: "in_progress"))
              .or(Feedback.where(status: "live"))
              .group(:status)
              .count
    end

    def roadmap_status_zero_count
      { "planned" => 0, "in_progress" => 0, "live" => 0 }
    end
  end
end

module Suggestions
  class SuggestionsIndex
    def suggestions_index
      roadmap = roadmap_status_zero_count.merge(roadmap_status_count)
      feedbacks = Feedback.where(status: "suggestion")

      Result.new(roadmap: roadmap, roadmap_colors: roadmap_colors, feedbacks: feedbacks)
    end

    class Result
      attr_reader :feedbacks, :roadmap, :roadmap_colors

      def initialize(feedbacks:, roadmap:, roadmap_colors:)
        @feedbacks = feedbacks
        @roadmap = roadmap
        @roadmap_colors = roadmap_colors
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

    def roadmap_colors
      { "planned" => "bg-red-100", "in_progress" => "bg-purple-200", "live" => "bg-indigo-100" }
    end
  end
end

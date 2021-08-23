module Suggestions
  class SuggestionsIndex
    def suggestions_index(category: nil, sort: nil)
      roadmap = roadmap_status_zero_count.merge(roadmap_status_count)
      feedbacks = if category
                    Feedback.where(status: "suggestion").where(category: category)
                  else
                    Feedback.where(status: "suggestion")
                  end

      Result.new(roadmap: roadmap, roadmap_colors: roadmap_colors, feedbacks: feedbacks.order(order_by(sort)))
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

    def order_by(sort)
      return "upvotes desc" unless %w[upvotes-desc upvotes-asc comments-desc comments-asc].include?(sort)

      sort.split("-").join(" ")
    end
  end
end

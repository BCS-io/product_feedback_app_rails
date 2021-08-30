module Suggestions
  class SuggestionsIndex
    def suggestions_index(category: nil, sort: nil)
      roadmap = roadmap_status_zero_count.merge(roadmap_status_count)
      feedbacks = if category.present?
                    Feedback.where(status: "suggestion").where(category: category)
                  else
                    Feedback.where(status: "suggestion")
                  end

      Result.new(roadmap: roadmap, feedbacks: feedbacks.order(order_by(sort)))
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
      Feedback.where(status: %w[planned in_progress live])
              .group(:status)
              .count
    end

    def roadmap_status_zero_count
      { "planned" => 0, "in_progress" => 0, "live" => 0 }
    end

    def order_by(sort)
      return "upvotes_count desc" unless %w[upvotes_count-desc upvotes_count-asc comments_count-desc
                                            comments_count-asc].include?(sort)

      sort.split("-").join(" ")
    end
  end
end

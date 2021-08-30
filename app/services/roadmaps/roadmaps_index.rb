module Roadmaps
  class RoadmapsIndex
    def roadmaps_index
      status_frequency = roadmap_status_zero_count.merge(roadmap_status_count)

      planned = Feedback.where(status: "planned").order(upvotes_count: :desc)
      in_progress = Feedback.where(status: "in_progress").order(upvotes_count: :desc)
      live = Feedback.where(status: "live").order(upvotes_count: :desc)

      Result.new(planned: planned, in_progress: in_progress, live: live, status_frequency: status_frequency)
    end

    class Result
      attr_reader :planned, :in_progress, :live, :status_frequency

      def initialize(planned:, in_progress:, live:, status_frequency:)
        @planned = planned
        @in_progress = in_progress
        @live = live
        @status_frequency = status_frequency
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
  end
end

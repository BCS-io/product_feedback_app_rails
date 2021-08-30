require "rails_helper"

module Roadmaps
  RSpec.describe RoadmapsIndex, type: :service do
    describe "planned" do
      it "returns only planned feedbacks" do
        feedback = create(:feedback, status: "planned", user: create(:staff))
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.planned).to eq [feedback]
      end

      it "does not return none-planned feedbacks" do
        %w[suggestion in_progress live].each do |status|
          create(:feedback, status: status, user: create(:staff))
        end
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.planned).to eq []
      end

      it "orders by upvotes descending" do
        create(:feedback, status: "planned", user: create(:user))
        feedback2 = create(:feedback, status: "planned", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback2)

        result = RoadmapsIndex.new.roadmaps_index

        expect(result.planned[0].upvotes_count).to eq 1
        expect(result.planned[1].upvotes_count).to eq 0
      end
    end

    describe "in_progress" do
      it "returns only in_progress feedbacks" do
        feedback = create(:feedback, status: "in_progress", user: create(:staff))
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.in_progress).to eq [feedback]
      end

      it "does not return none-planned feedbacks" do
        %w[suggestion planned live].each do |status|
          create(:feedback, status: status, user: create(:staff))
        end
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.in_progress).to eq []
      end

      it "orders by upvotes descending" do
        create(:feedback, status: "in_progress", user: create(:user))
        feedback2 = create(:feedback, status: "in_progress", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback2)

        result = RoadmapsIndex.new.roadmaps_index

        expect(result.in_progress[0].upvotes_count).to eq 1
        expect(result.in_progress[1].upvotes_count).to eq 0
      end
    end

    describe "live" do
      it "returns only live feedbacks" do
        feedback = create(:feedback, status: "live", user: create(:staff))
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.live).to eq [feedback]
      end

      it "does not return none-planned feedbacks" do
        %w[suggestion planned in_progress].each do |status|
          create(:feedback, status: status, user: create(:staff))
        end
        result = RoadmapsIndex.new.roadmaps_index
        expect(result.live).to eq []
      end

      it "orders by upvotes descending" do
        create(:feedback, status: "live", user: create(:user))
        feedback2 = create(:feedback, status: "live", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback2)

        result = RoadmapsIndex.new.roadmaps_index

        expect(result.live[0].upvotes_count).to eq 1
        expect(result.live[1].upvotes_count).to eq 0
      end
    end

    describe "status_frequency" do
      it "returns roadmap statuses by count" do
        user = create(:user)
        create_list(:feedback, 3, status: "planned", user: user)
        create_list(:feedback, 2, status: "in_progress", user: user)
        create_list(:feedback, 1, status: "live", user: user)

        result = RoadmapsIndex.new.roadmaps_index

        expect(result.status_frequency).to eq({ "planned" => 3, "in_progress" => 2, "live" => 1 })
      end

      it "returns feedbacks status counts as zero if missing" do
        result = RoadmapsIndex.new.roadmaps_index

        expect(result.status_frequency).to eq({ "planned" => 0, "in_progress" => 0, "live" => 0 })
      end
    end
  end
end

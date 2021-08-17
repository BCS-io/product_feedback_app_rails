require "rails_helper"

module Suggestions
  RSpec.describe SuggestionsIndex, type: :services do
    describe "feedbacks" do
      it "allows feedback suggestions" do
        user = create(:user)
        create_list(:feedback, 3, status: "suggestion", user: user)

        result = SuggestionsIndex.new.suggestions_index

        expect(result.feedbacks).to match_array(Feedback.all)
      end

      it "rejects feedbacks that aren't suggestions" do
        user = create(:user)
        create(:feedback, status: "planned", user: user)
        create(:feedback, status: "in_progress", user: user)
        create(:feedback, status: "live", user: user)

        result = SuggestionsIndex.new.suggestions_index

        expect(result.feedbacks).to match_array([])
      end
    end

    describe "roadmap" do
      it "returns roadmap statuses by count" do
        user = create(:user)
        create_list(:feedback, 3, status: "planned", user: user)
        create_list(:feedback, 2, status: "in_progress", user: user)
        create_list(:feedback, 1, status: "live", user: user)

        result = SuggestionsIndex.new.suggestions_index

        expect(result.roadmap).to eq({ "planned" => 3, "in_progress" => 2, "live" => 1 })
      end

      it "returns feedbacks status counts as zero if missing" do
        result = SuggestionsIndex.new.suggestions_index

        expect(result.roadmap).to eq({ "planned" => 0, "in_progress" => 0, "live" => 0 })
      end
    end

    describe "roadmap_colors" do
      it "has expected colors" do
        result = SuggestionsIndex.new.suggestions_index

        expect(result.roadmap_colors["planned"]).to eq("bg-red-100")
        expect(result.roadmap_colors["in_progress"]).to eq("bg-purple-200")
        expect(result.roadmap_colors["live"]).to eq("bg-indigo-100")
      end
    end
  end
end

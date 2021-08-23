require "rails_helper"

module Suggestions
  RSpec.describe SuggestionsIndex, type: :service do
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

      it "returns feedback suggestions matching category" do
        user = create(:user)
        create_list(:feedback, 2, status: "suggestion", category: "ui", user: user)

        result = SuggestionsIndex.new.suggestions_index(category: "ui")

        expect(result.feedbacks.count).to eq(2)
      end

      it "returns no feedback suggestions if no matching category" do
        user = create(:user)
        create_list(:feedback, 1, status: "suggestion", category: "ui", user: user)

        result = SuggestionsIndex.new.suggestions_index(category: "bug")

        expect(result.feedbacks.count).to eq(0)
      end
    end

    describe "ordering" do
      it "orders by upvotes descending by default" do
        create(:feedback, status: "suggestion", user: create(:user))
        feedback2 = create(:feedback, status: "suggestion", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback2)

        result = SuggestionsIndex.new.suggestions_index(sort: nil)

        expect(result.feedbacks[0].upvotes_count).to eq 1
        expect(result.feedbacks[1].upvotes_count).to eq 0
      end

      it "orders by upvotes descending" do
        create(:feedback, status: "suggestion", user: create(:user))
        feedback2 = create(:feedback, status: "suggestion", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback2)

        result = SuggestionsIndex.new.suggestions_index(sort: "upvotes_count-desc")

        expect(result.feedbacks[0].upvotes_count).to eq 1
        expect(result.feedbacks[1].upvotes_count).to eq 0
      end

      it "orders by upvotes ascending" do
        feedback1 = create(:feedback, status: "suggestion", user: create(:user))
        create(:vote, user: create(:user), feedback: feedback1)
        create(:feedback, status: "suggestion", user: create(:user))

        result = SuggestionsIndex.new.suggestions_index(sort: "upvotes_count-asc")

        expect(result.feedbacks[0].upvotes_count).to eq 0
        expect(result.feedbacks[1].upvotes_count).to eq 1
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
  end
end

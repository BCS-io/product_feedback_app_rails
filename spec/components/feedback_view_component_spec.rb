require "rails_helper"

RSpec.describe FeedbackViewComponent, type: :component do
  it "changes capitalization of text" do
    feedback = create(:feedback, title: "another", category: "enhancement", user: create(:user))
    render_inline(FeedbackViewComponent.new(feedback: feedback, current_user: create(:user)))

    expect(rendered_component).to have_text("Another")
    expect(rendered_component).to have_text("Enhancement")
  end

  describe "#text_limit" do
    it "applies text limits when true" do
      feedback = create(:feedback,
                        title: "this title",
                        description: "this description",
                        user: create(:user))

      render_inline(FeedbackViewComponent.new(feedback: feedback,
                                              current_user: create(:user),
                                              text_limit: true))

      expect(rendered_component).to have_selector("h3.overflow-hidden.overflow-ellipsis",
                                                  text: "This title")
      expect(rendered_component).to have_selector("div.overflow-hidden.overflow-ellipsis",
                                                  text: "this description")
    end

    it "has not text limits when false" do
      feedback = create(:feedback,
                        title: "this title",
                        description: "this description",
                        user: create(:user))

      render_inline(FeedbackViewComponent.new(feedback: feedback,
                                              current_user: create(:user),
                                              text_limit: false))

      expect(rendered_component).to have_selector("h3.test-no-text-limit",
                                                  text: "This title")
      expect(rendered_component).to have_selector("div.test-no-text-limit",
                                                  text: "this description")
    end
  end

  describe "voted" do
    it "has style when not voted" do
      feedback = create(:feedback, title: "another", category: "enhancement", user: create(:user))
      current_user = create(:user)

      render_inline(FeedbackViewComponent.new(feedback: feedback, current_user: current_user))

      expect(rendered_component).to have_css(".bg-gray-100.text-indigo-200", text: "0")
    end

    it "has style when voted" do
      feedback = create(:feedback, title: "another", category: "enhancement", user: create(:user))
      current_user = create(:user)
      create(:vote, user: current_user, feedback: feedback)

      render_inline(FeedbackViewComponent.new(feedback: feedback, current_user: current_user))

      expect(rendered_component).to have_css(".bg-indigo-200.text-white", text: "1")
    end
  end
end

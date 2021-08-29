require "rails_helper"

RSpec.describe FeedbackViewComponent, type: :component do
  it "changes capitalization of text" do
    feedback = create(:feedback, title: "another", category: "enhancement", user: create(:user))
    render_inline(FeedbackViewComponent.new(feedback: feedback, current_user: create(:user)))

    expect(rendered_component).to have_text("Another")
    expect(rendered_component).to have_text("Enhancement")
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

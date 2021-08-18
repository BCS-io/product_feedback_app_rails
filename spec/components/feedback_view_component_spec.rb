require "rails_helper"

RSpec.describe FeedbackViewComponent, type: :component do
  it "changes capitalization of text" do
    feedback = build(:feedback, title: "another", category: "enhancement")
    render_inline(FeedbackViewComponent.new(feedback: feedback))

    expect(rendered_component).to have_text("Another")
    expect(rendered_component).to have_text("Enhancement")
  end
end

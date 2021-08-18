require "rails_helper"

RSpec.describe FeedbackViewComponent, type: :component do
  it "changes capitalization of text" do
    feedback = create(:feedback, title: "another", category: "enhancement", user: create(:user))
    render_inline(FeedbackViewComponent.new(feedback: feedback))

    expect(rendered_component).to have_text("Another")
    expect(rendered_component).to have_text("Enhancement")
  end
end

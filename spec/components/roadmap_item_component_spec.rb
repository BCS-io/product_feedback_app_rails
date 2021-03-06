require "rails_helper"

RSpec.describe RoadmapItemComponent, type: :component do
  it "renders roadmap item" do
    feedback = create(:feedback,
                      title: "another",
                      description: "all you need to know",
                      category: "enhancement",
                      user: create(:user))
    render_inline(RoadmapItemComponent.new(feedback: feedback, current_user: create(:user)))

    expect(rendered_component).to have_css(".text-xs", text: "Another")
    # two lines of text only
    expect(rendered_component).to have_css(".text-xs.leading-5.h-10", text: "all you need to know")
    expect(rendered_component).to have_text("Enhancement")
  end
end

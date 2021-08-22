require "rails_helper"

RSpec.describe EditFeedbackLinkComponent, type: :component do
  it "allows customers to edit feedbacks they own" do
    customer = create(:customer)
    feedback = create(:feedback, user: customer)
    render_inline(EditFeedbackLinkComponent.new(feedback: feedback, current_user: customer))

    expect(rendered_component).to have_link "Edit Feedback", href: edit_feedback_path(feedback)
  end

  it "denys customers to edit feedbacks of others" do
    owner = create(:customer)
    current_user = create(:customer)
    feedback = create(:feedback, user: owner)
    render_inline(EditFeedbackLinkComponent.new(feedback: feedback, current_user: current_user))

    expect(rendered_component).not_to have_link "Edit Feedback"
  end
end

require "rails_helper"

RSpec.describe NotificationComponent, type: :component do
  it "renders a notice as expected" do
    render_inline(NotificationComponent.new(type: "notice", message: "Successfully logged in"))

    expect(rendered_component).to have_css(".bg-green-50 .text-green-700", text: "Successfully logged in")
  end

  it "renders an alert as expected" do
    render_inline(NotificationComponent.new(type: "alert", message: "Unauthorized access"))

    expect(rendered_component).to have_css(".bg-red-50 .text-red-700", text: "Unauthorized access")
  end

  it "errors" do
    expect do
      render_inline(NotificationComponent.new(type: "ANewErrorType", message: "Unauthorized access"))
    end.to raise_error(UnknownNotificationError, "ANewErrorType notification is unknown")
  end
end

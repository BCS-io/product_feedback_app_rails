require "rails_helper"

RSpec.describe CategoryLinksComponent, type: :component do
  it "highlights matching category links" do
    render_inline(CategoryLinksComponent.new(category: "ux"))

    expect(rendered_component).to have_css(".bg-indigo-200.text-white", text: "UX")
  end

  it "backgrounds unlike category links" do
    render_inline(CategoryLinksComponent.new(category: "bug"))

    expect(rendered_component).to have_css(".bg-gray-200.text-indigo-200", text: "UX")
  end

  it "highlights 'all' if no category given" do
    render_inline(CategoryLinksComponent.new(category: nil))

    expect(rendered_component).to have_css(".bg-indigo-200.text-white", text: "All")
  end
end

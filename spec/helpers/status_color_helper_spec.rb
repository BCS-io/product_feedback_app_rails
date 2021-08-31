require "rails_helper"

RSpec.describe StatusColorHelper, type: :helper do
  it "has expected background colors" do
    expect(status_to_bg_color["planned"]).to eq("bg-red-100")
    expect(status_to_bg_color["in_progress"]).to eq("bg-purple-200")
    expect(status_to_bg_color["live"]).to eq("bg-blue-100")
  end

  it "has expected border colors" do
    expect(status_to_border_color["planned"]).to eq("border-red-100")
    expect(status_to_border_color["in_progress"]).to eq("border-purple-200")
    expect(status_to_border_color["live"]).to eq("border-blue-100")
  end
end

require "rails_helper"

RSpec.describe EnumHelper, type: :helper do
  it "creates option elements hash with i18n values" do
    feedback = Feedback.new(status: nil)
    option_elements = options_for_enum(feedback, :status)
    expect(option_elements).to eq %(<option value="suggestion">Suggestion</option>\n) +
                                  %(<option value="planned">Planned</option>\n) +
                                  %(<option value="in_progress">In-Progress</option>\n) +
                                  %(<option value="live">Live</option>)
  end

  it "creates option elements hash with i18n values and selected" do
    feedback = Feedback.new(status: :suggestion)
    option_elements = options_for_enum(feedback, :status)
    expect(option_elements).to eq %(<option selected="selected" value="suggestion">Suggestion</option>\n) +
                                  %(<option value="planned">Planned</option>\n) +
                                  %(<option value="in_progress">In-Progress</option>\n) +
                                  %(<option value="live">Live</option>)
  end
end

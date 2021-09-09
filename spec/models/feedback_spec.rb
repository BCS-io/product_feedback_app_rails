require "rails_helper"

RSpec.describe Feedback, type: :model do
  describe "validations" do
    %i[title category status description].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to validate_length_of(:title).is_at_most(120) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
  end
end

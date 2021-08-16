require "rails_helper"

RSpec.describe Feedback, type: :model do
  %i[title category status description].each do |attribute|
    it { is_expected.to validate_presence_of(attribute) }
  end
end

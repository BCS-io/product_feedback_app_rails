require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_least(3).is_at_most(250) }
  end
end

require "rails_helper"

RSpec.describe VotePolicy, type: :policy do
  subject { VotePolicy.new(user, feedback) }

  let(:feedback) { Feedback.create }

  context "when a visitor" do
    let(:user) { nil }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "when a customer" do
    let(:user) { build_stubbed(:user) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when a record owner" do
    let(:user) { create(:user) }
    let(:feedback) { create(:feedback, user: user) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when staff" do
    let(:user) { create(:staff) }

    let(:customer) { create(:customer) }
    let(:feedback) { create(:feedback, user: customer) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:destroy) }
  end
end

class Feedback < ApplicationRecord
  belongs_to :user

  enum category: { enhancement: "enhancement", feature: "feature", bug: "bug", ui: "ui", ux: "ux" }, _prefix: true
  enum status: { suggestion: "suggestion", planned: "planned", in_progress: "in_progress", live: "live" }, _prefix: true

  validates :title, :category, :upvotes, :status, :description, presence: true
end

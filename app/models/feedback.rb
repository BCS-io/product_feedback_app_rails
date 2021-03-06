class Feedback < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum category: { enhancement: "enhancement", feature: "feature", bug: "bug", ui: "ui", ux: "ux" }, _prefix: true
  enum status: { suggestion: "suggestion", planned: "planned", in_progress: "in_progress", live: "live" }, _prefix: true

  MAX_TITLE_LENGTH = 120
  MAX_DESCRIPTION_LENGTH = 500
  validates :title, :category, :status, :description, presence: true
  validates :title, length: { maximum: MAX_TITLE_LENGTH }
  validates :description, length: { maximum: MAX_DESCRIPTION_LENGTH }
end

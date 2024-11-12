class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates :customer_id, :tea_id, :title, :price, :status, :frequency, presence: true
  validates :customer_id, :tea_id, numericality: { only_integer: true }
  validates :price, numericality: true
  validates :status, inclusion: { in: %w(active canceled), message: "Invalid Status" }
end
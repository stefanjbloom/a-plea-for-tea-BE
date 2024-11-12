class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates :title, :description, :temperature, :brewtime, presence: true
  validates :temperature, :brewtime, numericality: true
end
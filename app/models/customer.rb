class Customer < ApplicationRecord
    has_many :subscriptions
    has_many :teas, through: :subscriptions

    validates :firstname, :lastname, :email, :address, presence: true
    validates :firstname, length: { maximum: 40}
    validates :lastname, length: { maximum: 40}
    validates :email, format: { with: /\A(.+)@(.+)\z/, message: "Invalid Email Address"  }
    validates :email, uniqueness: true
end
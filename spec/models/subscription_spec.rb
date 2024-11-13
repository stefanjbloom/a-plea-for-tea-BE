require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:customer_id)  }
    it { should validate_presence_of(:tea_id)  }
    it { should validate_presence_of(:title)  }
    it { should validate_presence_of(:price)  }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
    it { should validate_numericality_of(:customer_id).only_integer }
    it { should validate_numericality_of(:tea_id).only_integer }
    it { should validate_numericality_of(:price) }
    it { should validate_inclusion_of(:status).in_array(%w(active canceled)).with_message("Invalid Status") }
    it { should validate_inclusion_of(:frequency).in_array(%w(weekly monthly)).with_message("Only Weekly or Monthly") }
  end

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end

  describe '#update_subscription' do
    it 'changes subscriptions status from "canceled" to "active" & vice versa' do
      @customer1 = Customer.create!(firstname: "Stefan", lastname: "Shepard", email: "stefan12@example.com", address: "10 Example Circle")

      @tea1 = Tea.create!(title: "Matcha Tea", description: "An energizing green tea.", temperature: 130, brewtime: 3)

      @subscription1 = Subscription.create!(title: "Monthly Matcha", price: 19.99, status: "active", 
                                            frequency: "monthly", customer_id: @customer1.id, tea_id: @tea1.id)

      expect(@subscription1.status).to eq("active")

      @subscription1.update_subscription!
      expect(@subscription1.status).to eq("canceled")

      @subscription1.update_subscription!
      expect(@subscription1.status).to eq("active")

    end
  end
end
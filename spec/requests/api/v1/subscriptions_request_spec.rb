require 'rails_helper'

RSpec.describe "Subscriptions_Controller", type: :request do
  describe "GET/index" do
    before(:each) do
      @customer1 = Customer.create!(firstname: "Stefan", lastname: "Shepard", email: "stefan@example.com", address: "10 Example Circle")
      @customer2 = Customer.create!(firstname: "JT", lastname: "Ruggier", email: "JT77@example.com", address: "20 Example Street")
      @customer3 = Customer.create!(firstname: "Annette", lastname: "Nathan", email: "woodster@example.com", address: "30 Example Lane")

      @tea1 = Tea.create!(title: "Matcha Tea", description: "An energizing green tea.", temperature: 130, brewtime: 3)
      @tea2 = Tea.create!(title: "Tulsi Ashwaganda Tea", description: "Healthy and delicious.", temperature: 120, brewtime: 4)
      @tea3 = Tea.create!(title: "Mint Tea", description: "Minty Freshness.", temperature: 125, brewtime: 5)

      @subscription1 = Subscription.create!(title: "Monthly Matcha", price: 19.99, status: "active", frequency: "monthly", customer: @customer1, tea: @tea1)
      @subscription2 =Subscription.create!(title: "Tuesday Tulsi", price: 4.99, status: "active", frequency: "weekly", customer: @customer2, tea: @tea2)
      @subscription3 =Subscription.create!(title: "Monthly Mint", price: 14.99, status: "canceled", frequency: "monthly", customer: @customer3, tea: @tea3)
    end

    it '#index can retrieve all tea subscriptions' do

      get "/api/v1/subscriptions"

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to eq([@subscription1, @subscription2, @subscription3])
    end
  end
end
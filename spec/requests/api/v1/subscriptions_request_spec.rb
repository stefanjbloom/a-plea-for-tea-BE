require 'rails_helper'

RSpec.describe "Subscriptions_Controller", type: :request do
  before(:each) do
    Subscription.delete_all

    @customer1 = Customer.create!(firstname: "Stefan", lastname: "Shepard", email: "stefan12@example.com", address: "10 Example Circle")
    @customer2 = Customer.create!(firstname: "JT", lastname: "Ruggier", email: "JT7712@example.com", address: "20 Example Street")
    @customer3 = Customer.create!(firstname: "Annette", lastname: "Nathan", email: "woodster12@example.com", address: "30 Example Lane")
    
    @tea1 = Tea.create!(title: "Matcha Tea", description: "An energizing green tea.", temperature: 130, brewtime: 3)
    @tea2 = Tea.create!(title: "Tulsi Ashwaganda Tea", description: "Healthy and delicious.", temperature: 120, brewtime: 4)
    @tea3 = Tea.create!(title: "Mint Tea", description: "Minty Freshness.", temperature: 125, brewtime: 5)
    
    @subscription1 = Subscription.create!(title: "Monthly Matcha", price: 19.99, status: "active", frequency: "monthly", customer_id: @customer1.id, tea_id: @tea1.id)
    @subscription2 =Subscription.create!(title: "Tuesday Tulsi", price: 4.99, status: "active", frequency: "weekly", customer_id: @customer2.id, tea_id: @tea2.id)
    @subscription3 =Subscription.create!(title: "Monthly Mint", price: 14.99, status: "canceled", frequency: "monthly", customer_id: @customer3.id, tea_id: @tea3.id)
  end
  
  describe "GET/index" do
    it '#index can retrieve all tea subscriptions' do

      get "http://localhost:3000/api/v1/subscriptions"
      # without localhost:3000, I was consistently getting a 403 error for GET example.com

      expect(response).to have_http_status(:ok)

      results = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(results.size).to eq(3)
      
      results.each do |result| 
        expect(result).to have_key(:id)

        expect(result).to have_key(:type)
        expect(result[:type]).to eq("subscription")

        expect(result).to have_key(:attributes)

        result = result[:attributes]

        expect(result[:customer_id]).to be_an(Integer)
        expect(result[:tea_id]).to be_an(Integer)
        expect(result[:title]).to be_an(String)
        expect(result[:status]).to be_an(String)
        expect(result[:price].to_f).to be_an(Float)
        expect(result[:frequency]).to be_an(String)

      end

    end
  end
end
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

  describe "GET/show" do
    it '#show can retrieve a single subscription including tea and customer data' do

      get "http://localhost:3000/api/v1/subscriptions/#{@subscription2.id}"

      expect(response).to have_http_status(:ok)

      results = JSON.parse(response.body, symbolize_names: true)
      
      expect(results.size).to eq(1)

      result = results[:data]

      expect(result[:id].to_i).to eq(@subscription2.id)
      expect(result[:type]).to eq("subscription")

      result = results[:data][:attributes]

      expect(result).to have_key(:customer)
      expect(result[:customer][:id]).to eq(@customer2.id)
      expect(result[:customer][:firstname]).to eq(@customer2.firstname)
      expect(result[:customer][:lastname]).to eq(@customer2.lastname)
      expect(result[:customer][:email]).to eq(@customer2.email)
      expect(result[:customer][:address]).to eq(@customer2.address)

      expect(result).to have_key(:tea)
      expect(result[:tea][:id]).to eq(@tea2.id)
      expect(result[:tea][:title]).to eq(@tea2.title)
      expect(result[:tea][:description]).to eq(@tea2.description)
      expect(result[:tea][:temperature]).to eq(@tea2.temperature)
      expect(result[:tea][:brewtime]).to eq(@tea2.brewtime)
    end

    it '(SADPATH)throws exception if subscription/:id does not exist' do

      get "http://localhost:3000/api/v1/subscriptions/1000"

      expect(response).to have_http_status(:not_found)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq("Subscription not found")
      expect(result[:errors]).to eq(["Couldn't find Subscription with 'id'=1000"])
    end
  end
end
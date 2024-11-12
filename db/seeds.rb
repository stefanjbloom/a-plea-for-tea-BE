# at least 3 seeds each for our 3(total) tables

Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all
# prevents duplicates if/when re-seeding

customers = [
  { firstname: "Stefan", lastname: "Shepard", email: "stefan@example.com", address: "10 Example Circle" },
  { firstname: "JT", lastname: "Ruggier", email: "JT77@example.com", address: "20 Example Street" },
  { firstname: "Annette", lastname: "Nathan", email: "woodster@example.com", address: "30 Example Lane" }
]
customers.each { |customer| Customer.create!(customer) }

teas = [
  { title: "Matcha Tea", description: "An energizing green tea.", temperature: 130, brewtime: 3 },
  { title: "Tulsi Ashwaganda Tea", description: "Healthy and delicious.", temperature: 120, brewtime: 4 },
  { title: "Mint Tea", description: "Minty Freshness.", temperature: 125, brewtime: 5 }
]
teas.each { |tea| Tea.create!(tea) }

subscriptions = [
  { title: "Monthly Matcha", price: 19.99, status: "active", frequency: "monthly", customer_id: Customer.all.sample.id, tea_id: Tea.find_by(title: "Matcha Tea").id },
  { title: "Tuesday Tulsi", price: 4.99, status: "active", frequency: "weekly", customer_id: Customer.all.sample.id, tea_id: Tea.find_by(title: "Tulsi Ashwaganda Tea").id },
  { title: "Monthly Mint", price: 14.99, status: "canceled", frequency: "monthly", customer_id: Customer.all.sample.id, tea_id: Tea.find_by(title: "Mint Tea").id }
]
subscriptions.each { |subscription| Subscription.create!(subscription) }
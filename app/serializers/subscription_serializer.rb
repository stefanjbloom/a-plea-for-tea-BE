class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :customer_id, :tea_id, :title, :price, :status, :frequency
  # attribute :tea, if: :include_tea?
  # attribute :customer, if: :include_customer?
 
end

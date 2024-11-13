class SubscriptionShowSerializer
  include JSONAPI::Serializer

  set_type :subscription

  attributes :title, :price, :status, :frequency

  attribute :customer, serializer: CustomerSerializer
  attribute :tea, serializer: TeaSerializer
end
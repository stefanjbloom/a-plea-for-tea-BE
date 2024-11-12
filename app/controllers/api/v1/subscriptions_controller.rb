class Api::V1::SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.all
  end
end

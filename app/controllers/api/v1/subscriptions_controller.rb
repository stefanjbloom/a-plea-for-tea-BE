class Api::V1::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    subscriptions = Subscription.all
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionShowSerializer.new(subscription), status: :ok
  end

  def update
    subscription = Subscription.find(params[:id])
    if subscription.update_subscription
      render json: SubscriptionShowSerializer.new(subscription), status: :ok
    else
      render json: { error: "Failed to update subscription status" }, status: :unprocessable_entity
    end
  end

  private
  
  def not_found_response(exception)
    render json: ErrorSerializer.format_error(exception, "404"), status: :not_found
  end
end


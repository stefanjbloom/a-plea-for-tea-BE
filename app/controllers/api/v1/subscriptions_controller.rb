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
    begin
      subscription.update_subscription!
      render json: { message: "Subscription Status Changed", status: subscription.status }, status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: "Failed to update subscription", errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def not_found_response(exception)
    render json: ErrorSerializer.format_error(exception, "404"), status: :not_found
  end
end


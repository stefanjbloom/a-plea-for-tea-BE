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

  private
  
  def not_found_response(exception)
    render json: ErrorSerializer.format_error(exception, "404"), status: :not_found
  end
end

# An endpoint to get info about one subscription, including the tea(s) involved and 
# what customer(s) is subscribed or has been in the past (if cancelled)

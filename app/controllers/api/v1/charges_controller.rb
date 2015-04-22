module Api
  module V1
    class ChargesController < ApplicationController

      def create
        begin
          charge = Stripe::Charge.create(
            amount: params[:charge][:amount],
            currency: params[:charge][:currency],
            source: params[:charge][:token_id], # obtained with Stripe.js
            description: params[:charge][:description],
            receipt_email: params[:charge][:email]
          )

          render json: charge

        rescue Stripe::APIError => e
          render json: { error: e.message }, status: :unprocessable_entity
        rescue Stripe::InvalidRequestError => e
          render json: { error: e.message }, status: :unprocessable_entity
        rescue Stripe::CardError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
      end
    end
  end
end
class PaymentsController < ApplicationController
  before_action :set_participation

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @participation.amount_cents,
      description:  "Payment for gift #{@participation.gift.name} for order #{@participation.id}",
      currency:     @participation.amount.currency
    )

    @participation.update(payment: charge.to_json, state: 'paid')
    redirect_to participation_path(@participation)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_participation_payment_path(@participation)
  end

private

  def set_participation
    @participation = Participation.where(state: 'pending').find(params[:participation_id])
  end
end

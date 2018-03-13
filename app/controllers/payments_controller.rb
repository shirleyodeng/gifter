class PaymentsController < ApplicationController
  before_action :set_participation

  def new
    authorize @participation
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )
    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @participation.amount_cents,
      description:  "Payment for gift #{@participation.gift.capitalized_name} for contribution #{@participation.id}",
      currency:     @participation.amount.currency
    )
    @participation.update(payment: charge.to_json, state: 'paid')
    authorize @participation
    @conversation = Conversation.where(sender_id: current_user.id, recipient_id: @participation.gift.event.creator.id, event_id: @participation.gift.event.id).first
    @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: @participation.gift.event.creator.id, event_id: @participation.gift.event.id) if @conversation.nil?
    @message = @conversation.messages.new(body: "-- #{current_user.full_name} contributed £#{@participation.amount} towards #{@participation.gift.name} --")
    @message.user = current_user
    @message.conversation = @conversation
    @message.save
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

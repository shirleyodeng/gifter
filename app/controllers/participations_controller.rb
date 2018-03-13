class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :update]

  def show
    redirect_to :root unless @participation.state == "paid"
  end

  def create
    @gift = Gift.find(params[:participation][:gift_id])
    @participation = Participation.create!(user: current_user, gift: @gift, amount: params[:participation][:amount].to_i, state: 'pending')
    authorize @participation
    redirect_to new_participation_payment_path(@participation)
  end

  def update
    @participation.update(participation_params)
    @conversation = Conversation.where(sender_id: current_user.id, recipient_id: @participation.gift.event.creator.id, event_id: @participation.gift.event.id).first
    @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: @participation.gift.event.creator.id, event_id: @participation.gift.event.id) if @conversation.nil?
    @message = @conversation.messages.new(body: participation_params[:gift_message])
    @message.user = current_user
    @message.conversation = @conversation
    @message.save
    redirect_to events_path
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
    authorize @participation
  end

  def participation_params
    params.require(:participation).permit(:gift_message)
  end
end

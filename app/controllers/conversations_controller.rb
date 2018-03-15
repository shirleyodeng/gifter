class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find(params[:event_id])
    @guests = @event.guests
    @conversations = Conversation.where(event: @event)
    @conversations = policy_scope(@conversations)
  end

  def create
    if Conversation.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).where(event_id: params[:event_id]).present?
      @conversation = Conversation.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).where(event_id: params[:event_id]).first
      authorize @conversation
    else
      @conversation = Conversation.create!(conversation_params)
      authorize @conversation
    end
    redirect_to event_conversation_messages_path(params[:event_id], @conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id, :event_id)
  end
end

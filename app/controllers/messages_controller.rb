class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :set_event

  def index
    @conversation.recipient == current_user ? @other_user = @conversation.sender : @other_user = @conversation.recipient
    @messages = policy_scope(@conversation.messages)
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    @message.conversation = @conversation
    authorize @message
    if @message.save
      redirect_to event_conversation_messages_path([@event, @conversation])
    else
      render :index
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end

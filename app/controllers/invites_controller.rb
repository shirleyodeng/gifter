class InvitesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @invite = Invite.new
    authorize @invite
  end

  def create
    @event = Event.find(params[:event_id])
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    authorize @invite
    if @invite.save
      if @invite.recipient != nil
        InviteMailer.existing_user_invite(@invite).deliver
        @invite.recipient.events.push(@invite.event)
      else
        InviteMailer.new_user_invite(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver
      end
      respond_to do |format|
        format.html { redirect_to event_gifts_path(params[:event_id]) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'gifts/index' }
        format.js
      end
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :event_id, :recipient_id, :token)
  end
end

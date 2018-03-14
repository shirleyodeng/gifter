class InvitesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @invite = Invite.new
    authorize @invite
  end

  def create
    @event = Event.find(params[:event_id])
    @invite = Invite.new(invite_params)
    @invite.recipient = User.find_by_email(params[:invite][:email])
    authorize @invite
    if not_invited_yet?
      @invite.sender_id = current_user.id
      if @invite.save
        if @invite.recipient != nil
          InviteMailer.existing_user_invite(@invite).deliver
          @invite.recipient.events.push(@invite.event)
        else
          InviteMailer.invite_to_event(@invite, @invite.token).deliver
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
    else
      #error message saying - they have already been invited
      redirect_to event_gifts_path(params[:event_id])
    end
  end

  def not_invited_yet?
    Invite.where(event_id: invite_params[:event_id]).where(email: invite_params[:email]).empty?
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :event_id, :recipient_id, :token)
  end
end

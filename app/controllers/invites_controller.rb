class InvitesController < ApplicationController
  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    authorize @invite
    if @invite.save
      if @invite.recipient != nil
        InviteMailer.existing_user_invite(@invite).deliver
        @invite.recipient.events.push(@invite.event)
        #js that it's email's been sent
      else
        # InviteMailer.new_user_invite(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver
        InviteMailer.invite_to_event(@invite, @invite.token).deliver
        #js that it's email's been sent
      end
    else
      #Creating an new invitation failed
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :event_id, :recipient_id, :token)
  end
end

class InviteMailer < ApplicationMailer
  def existing_user_invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: "You've been invited to an event!")
  end

  def invite_to_event(invite, token)
    @invite = invite
    @token = token
    mail(to: @invite.email, subject: "You've been invited to an event on Gifter by #{invite.sender.first_name}!")
  end
end

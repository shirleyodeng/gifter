class InviteMailer < ApplicationMailer
  def new_user_invite(invite, invite_url)
    @invite = invite
    @invite_url = invite_url
    mail(to: @invite.email, subject: "You've been invited to Gifter by #{invite.sender.first_name}")
  end

  def existing_user_invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: "You've been invited to an event!")
  end
end

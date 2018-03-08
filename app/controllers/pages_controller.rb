class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @invite = Invite.new #tempcode
  end
end

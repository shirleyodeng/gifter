class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:invite_token]
    super
  end

  def create
    @user = User.create(user_params)
    if @user.save
      @token = params[:invite_token]
      unless @token.nil?
        event =  Invite.find_by_token(@token).event
        @user.events.push(event)
        sign_in @user
        redirect_to event_gifts_path(event)
      else
        sign_in @user
        redirect_to events_path
      end
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end

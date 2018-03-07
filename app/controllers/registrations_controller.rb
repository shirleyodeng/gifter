class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
    super
  end

  def create
    @user = User.create(user_params)
    @user.save
    @token = params[:invite_token]
    unless @token.nil?
      event =  Invite.find_by_token(@token).event #find the user group attached to the invite
      @user.events.push(event) #add this user to the new user group as a member
      sign_in @user
      redirect_to event_gifts_path(event)
    else
      sign_in @user
      redirect_to events_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

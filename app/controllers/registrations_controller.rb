class RegistrationsController < Devise::RegistrationsController
  def new
    @token = params[:invite_token]
    super
  end

  def create
    @user = User.create(user_params)
    if @user.save
      if params[:invite_token].present?
        event = Invite.find_by_token(params[:invite_token]).event
        @user.events.push(event)
        sign_in @user
        redirect_to event_gifts_path(event)
      elsif params[:event_id].present?
        event = Event.find(params[:event_id])
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

  def create
    @user = User.create(user_params)
    if @user.save
      @event = params[:event_id]
      if @event.present?
        event = Event.find(params[:event_id])
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

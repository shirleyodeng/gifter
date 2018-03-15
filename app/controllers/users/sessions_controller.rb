class Users::SessionsController < Devise::SessionsController
  # def create
  #   #@event_id = params[:event_id]
  #   super
  #   session[:event_id] = resource.event_id
  # end

  def after_sign_in_path_for(resource)
    if params[:invite_token]
      event = Invite.find_by_token(params[:invite_token]).event
      return event_gifts_path(event)
    elsif params[:event_id].nil? || params[:event_id] == ''
      return events_path
    else
      event = Event.find(params[:event_id])
      current_user.events.push(event)
      return event_gifts_path(params[:event_id])
    end
  end
end

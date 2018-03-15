class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if params[:event_id].nil? || params[:event_id] = ''
      return events_path
    else
      return event_gifts_path(params[:event_id])
    end
  end
end

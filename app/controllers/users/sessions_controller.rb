class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if params[:event_id] != ''
      return event_gifts_path(params[:event_id])
    end
    super
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def after_sign_in_path_for(resource)
    # sign_in_url = new_user_session_url
    # if request.referer == sign_in_url
    #   super
    # else
    #   stored_location_for(resource) || request.referer || root_path
    # end
    if params[:event_id] != ''
      return event_gifts_url(params[:event_id])
    else
      return root_url
    end
  end
end

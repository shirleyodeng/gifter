class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.find_for_facebook_oauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in user, event: :authentication
      render_or_redirect
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    render_or_redirect
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('controllers.sessions.destroy')
  end

  protected

  def render_or_redirect
    page = request.env['omniauth.origin']
    if request.env['omniauth.params']['popup']
      @page = page
      render 'sessions/callback', layout: false
    else
      redirect_to page
    end
  end
end

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    check_and_redirect(OmniHandler.gen(:facebook), request.env['omniauth.auth'])
  end

  def twitter
    check_and_redirect(OmniHandler.gen(:twitter), request.env['omniauth.auth'])
  end

  def google_oauth2
    check_and_redirect(OmniHandler.gen(:google), request.env['omniauth.auth'])
  end

  private

  def check_and_redirect(handler, authdata)
    if ref = handler.find_or_create_ref(authdata)
      session['omnidata'] = { :code => handler.code, :account => ref.account }
      flash[:notice] = "Login with #{handler.code}"
      sign_in_and_redirect(ref.user, :event => :authentication)
    else
      flash[:notice] = "Failed to login with #{handler.code}"
      redirect_to root_path
    end
  end
end

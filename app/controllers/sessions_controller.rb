class SessionsController < ActionController::Base
  protect_from_forgery with: :exception

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.uid
    render 'layouts/logged_in.html'
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end

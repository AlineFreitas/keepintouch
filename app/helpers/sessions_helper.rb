module SessionsHelper
  def sign_in(collaborator)
    cookies.permanent[:remember_token] = collaborator.remember_token
    self.current_user = collaborator
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(collaborator)
    @current_user = collaborator
  end

  def current_user
    @current_user ||= Collaborator.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(collaborator)
    collaborator == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end

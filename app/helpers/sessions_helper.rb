module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    cookies.permanent.signed[:newCookie] = 'myNewCookie'
    user.update_attribute(:remember_token, remember_token)
    self.current_user = user
    logger.debug '---------------------------------------------------------'
    logger.debug cookies[:remember_token]
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = cookies[:remember_token]
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    logger.debug '+++++++++++++++++++++++++++++++++++++++'
    logger.debug current_user
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

end

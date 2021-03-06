module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    user.update_attribute(:remember_token, remember_token)
    cookies[:remember_token] = remember_token
    logger.debug '------------------------------------------------------------'
    logger.debug cookies[:remember_token]
    @current_user = user
  end

 #def current_user=(user)
 #   @current_user = user
 # end

  def current_user?(user)
    user == current_user
  end

  def current_user
    remember_token = cookies[:remember_token]
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
    cookies.delete(:remember_token)
  end

end

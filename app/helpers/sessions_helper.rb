module SessionsHelper

  def log_in(user)
    binding.pry
    self.current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    binding.pry
    @current_user = user
  end

  def current_user
    @current_user
  end

  def log_out
    self.current_user = nil
  end

end
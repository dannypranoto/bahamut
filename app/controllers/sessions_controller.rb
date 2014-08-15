class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    @user = user
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      log_in user
      redirect_to dashboard_path
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'login'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def login

  end

  def dashboard

  end

  def top_up

  end

  def profile

  end



end

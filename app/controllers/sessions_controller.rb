class SessionsController < ApplicationController
  def new; end

  def create
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash[:alert] = 'Invalid email or password'
      render :new, status: :bad_request
    end
  end

  def delete
    if session[:user_id].present?
      session[:user_id] = nil
      redirect_to root_path, notice: 'You are logged out'
    end
  end

  private

  def user
    return @user if defined?(@user)

    @user = User.find_by(email: params[:email])
  end
end

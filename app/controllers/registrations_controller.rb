class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Your account was successfully created'
    else
      render :new, status: :bad_request
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

class RegistrationsController < ApplicationController
  before_action :require_authentication
  before_action :authorize_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "¡Usuario registrado por el administrador exitosamente!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def authorize_admin!
    unless Current.user&.admin?
      redirect_to root_path, alert: "Solo administradores pueden crear usuarios."
    end
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :role)
  end
end

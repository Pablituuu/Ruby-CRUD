class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorize_admin!, only: %i[ index destroy ]
  before_action :authorize_user!, only: %i[ show edit update ]

  def index
    @users = User.all.order(created_at: :desc)
    @user = User.new # Necesario para el formulario del modal
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email_address, :role) # Admin can change role
  end

  def authorize_admin!
    unless Current.user.admin?
      redirect_to user_path(Current.user), alert: "Not authorized."
    end
  end

  def authorize_user!
    unless Current.user.admin? || Current.user == @user
      redirect_to user_path(Current.user), alert: "Not authorized."
    end
  end
end

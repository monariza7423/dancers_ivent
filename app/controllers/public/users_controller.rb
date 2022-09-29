class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @teams = @user.teams
  end
  
  def edit
    @user = current_user
  end
  
  def update
    user = current_user
    user.update(user_params)
    redirect_to user_path(current_user)
  end
  
  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
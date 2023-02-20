class UsersController < ApplicationController
  def update
    user_params
    user = User.find(@user[:user_id])
    authorize user
    user.update({:active => @user[:active], :role_id => @user[:role]})
    redirect_to companies_path(current_user)
  end

  private

  def user_params
    @user = params.require(:user).permit(:active, :role, :user_id)
    if @user[:role] == "master"
      @user[:role] = 1
    elsif @user[:role] == "manager"
      @user[:role] = 2
    elsif @user[:role] == "visitor"
      @user[:role] = 2
    end
  end

end

class UsersController < ApplicationController
  def update
    user_params
    user = User.find(@user[:user_id])
    authorize user
    user.update(:active => @user[:active])
    redirect_to companies_path(current_user)
  end

  private

  def user_params
    @user = params.require(:user).permit(:active, :user_id)
  end

end

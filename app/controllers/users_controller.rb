class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save!
      redirect_to root_path
    else
      redirect_to edit_user_path(@user)
      flash[:danger] = "Please provide a company name."
    end
  end

  private

  def user_params
    params.require(:user).permit(:company)
  end

end
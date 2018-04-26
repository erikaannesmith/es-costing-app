class SessionsController < ApplicationController

  def create
    user = User.update_or_create(request.env["omniauth.auth"])
    session[:id] = user.id
    if user.company.nil?
      redirect_to edit_user_path(user)
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
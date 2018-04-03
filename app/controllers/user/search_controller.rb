class User::SearchController < ApplicationController

  def index
    @clients = current_user.clients.where("lower(name) like ?", "%#{params[:search].downcase}%")
  end

end
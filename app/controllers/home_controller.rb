class HomeController < ApplicationController

  def index
    @clients = current_user.clients.order(:name)
  end

end
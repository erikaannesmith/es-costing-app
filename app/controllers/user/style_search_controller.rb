class User::StyleSearchController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @styles = @client.styles.where("lower(name) like ?", "%#{params[:search].downcase}%")
  end

end
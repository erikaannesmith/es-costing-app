class User::ClientsController < ApplicationController

  def show
    @client = Client.find(params[:id])
    @styles = @client.styles.order(:name)
  end

  def new
    @client = Client.new
  end

  def create
    @client = current_user.clients.create(client_params)
    if @client.save!
      redirect_to user_client_path(@client)
      flash[:success] = "#{@client.name} has been created!"
    else
      redirect_to root_path
      flash[:danger] = "#{@client.name} could not be created, please try again!"
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = current_user.clients.find(params["id"])
    @client.update(client_params)
    if @client.save!
      redirect_to user_client_path(@client)
      flash[:success] = "#{@client.name} has been updated!"
    else
      redirect_to root_path
      flash[:danger] = "#{@client.name} could not be updated, please try again!"
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email)
  end

end
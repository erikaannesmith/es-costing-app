class User::StylesController < ApplicationController

  def show
    @style = Style.find_by(id: params[:id], client_id: params[:client_id])
  end

  def new
    @style = Style.new
  end

  def create
    client = Client.find(params[:client_id])
    @style = client.styles.create(style_params)
    if @style.save!
      flash[:success] = "#{@style.name} has been created!"
      redirect_to user_client_style_path(client, @style)
    else
      redirect_to user_client_path(@style.client)
      flash[:danger] = "#{@style.name} could not be created, please try again!"
    end
  end

  def edit
    client = Client.find(params[:client_id])
    @style = client.styles.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])
    @style.update(style_params)
    if @style.save!
      redirect_to user_client_style_path(@style.client, @style)
      flash[:success] = "#{@style.name} has been updated!"
    else
      redirect_to user_client_path(@style.client)
      flash[:danger] = "#{@style.name} could not be updated, please try again!"
    end
  end

  private

  def style_params
    params.require(:style).permit(:name, :amount, :cost, :season)
  end

end
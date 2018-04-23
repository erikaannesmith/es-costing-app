class User::ShipNotificationsController < ApplicationController

  def index
  end

  def create
    @recipient = params[:recipient]
    @tracking_number = params[:tracking_number]
    @shipping_service = params[:shipping_service]
    @additional_notes = params[:additional_notes]
    @sender_email = current_user.email
    @sender_name = "#{current_user.first_name + ' ' +  current_user.last_name}"
    @shipping_reciept = params[:file].path
    @shipping_receipt_name = params[:file].original_filename
    send_shipping_notification(@recipient, @tracking_number, @shipping_service, @additional_notes, @sender_email, @sender_name, @shipping_reciept, @shipping_receipt_name)
  end

  def send_shipping_notification(recipient, tracking_number, shipping_service, additional_notes, sender_email, sender_name, shipping_reciept, shipping_receipt_name)
    UserMailer.welcome_email(recipient, tracking_number, shipping_service, additional_notes, sender_email, sender_name, shipping_reciept, shipping_receipt_name).deliver    
    redirect_to user_ship_notifications_path(current_user)
    flash[:notice] = "Shipping notification has been sent!"
  end
end
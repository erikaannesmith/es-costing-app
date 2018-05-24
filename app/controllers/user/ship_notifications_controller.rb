class User::ShipNotificationsController < ApplicationController

  def index
  end

  def create
    @recipient = params[:recipient]
    @tracking_number = params[:tracking_number]
    @shipping_service = params[:shipping_service]
    params[:additional_notes].present? ? @additional_notes = params[:additional_notes] : @additional_notes = ""
    @sender_email = current_user.email
    @sender_name = "#{current_user.first_name + ' ' +  current_user.last_name}"
    if params[:file].present?
      @shipping_reciept = params[:file].path
      @shipping_receipt_name = params[:file].original_filename
    else
      @shipping_reciept = ""
      @shipping_receipt_name = ""
    end
    if params[:file_two].present?
      @shipping_reciept_two = params[:file_two].path
      @shipping_receipt_name_two = params[:file_two].original_filename
    else
      @shipping_reciept_two = ""
      @shipping_receipt_name_two = ""
    end
    if params[:file_three].present?
      @shipping_reciept_three = params[:file_three].path
      @shipping_receipt_name_three = params[:file_three].original_filename
    else
      @shipping_reciept_three = ""
      @shipping_receipt_name_three = ""
    end
    @sender_company = current_user.company
    send_shipping_notification(@recipient, 
                               @tracking_number, 
                               @shipping_service, 
                               @additional_notes, 
                               @sender_email, 
                               @sender_name, 
                               @shipping_reciept, 
                               @shipping_receipt_name, 
                               @shipping_reciept_two, 
                               @shipping_receipt_name_two,
                               @shipping_reciept_three, 
                               @shipping_receipt_name_three,
                               @sender_company)
  end

  def send_shipping_notification(recipient, tracking_number, shipping_service, additional_notes, sender_email, sender_name, shipping_reciept, shipping_receipt_name, shipping_reciept_two, shipping_receipt_name_two, shipping_reciept_three, shipping_receipt_name_three, sender_company)
    UserMailer.welcome_email(recipient, 
                             tracking_number, 
                             shipping_service, 
                             additional_notes, 
                             sender_email, 
                             sender_name, 
                             shipping_reciept, 
                             shipping_receipt_name, 
                             shipping_reciept_two, 
                             shipping_receipt_name_two,
                             shipping_reciept_three, 
                             shipping_receipt_name_three,  
                             sender_company).deliver    
    redirect_to user_ship_notifications_path(current_user)
    flash[:success] = "Shipping notification has been sent!"
  end
end
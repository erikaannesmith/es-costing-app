class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email(recipient, tracking_number, shipping_service, additional_notes, sender_email, sender_name, shipping_receipt, shipping_receipt_name)
    @recipient = recipient
    @tracking_number = tracking_number
    @shipping_service = shipping_service
    @additional_notes = additional_notes
    @sender_email = sender_email
    @sender_name = sender_name
    @shipping_receipt = shipping_receipt
    @recipient_name = Client.find_by(email: @recipient).name
    if !@shipping_receipt.empty?
      attachments[shipping_receipt_name] = File.read(@shipping_receipt)
    end
    mail(to: @recipient, subject: 'Shipping Notification', bcc: @sender_email)
  end

end

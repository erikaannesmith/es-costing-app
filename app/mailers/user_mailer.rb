class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def welcome_email(recipient, 
                    tracking_number, 
                    shipping_service, 
                    additional_notes, 
                    sender_email, 
                    sender_name,
                    shipping_receipt, 
                    shipping_receipt_name, 
                    shipping_receipt_two, 
                    shipping_receipt_name_two,
                    shipping_receipt_three, 
                    shipping_receipt_name_three,
                    sender_company)
    @recipient = recipient
    @tracking_number = tracking_number
    @shipping_service = shipping_service
    @additional_notes = additional_notes
    @sender_email = sender_email
    @sender_name = sender_name
    @shipping_receipt = shipping_receipt
    @recipient_name = Client.find_by(email: @recipient).name
    @shipping_receipt_two = shipping_receipt_two
    @shipping_receipt_three = shipping_receipt_three
    @sender_company = sender_company
    if !@shipping_receipt.empty?
      attachments[shipping_receipt_name] = File.read(@shipping_receipt)
    end
    if !@shipping_receipt_two.empty?
      attachments[shipping_receipt_name_two] = File.read(@shipping_receipt_two)
    end
    if !@shipping_receipt_three.empty?
      attachments[shipping_receipt_name_three] = File.read(@shipping_receipt_three)
    end
    mail(to: @recipient, subject: "Shipping Notification from #{sender_company}", bcc: @sender_email)
  end

end

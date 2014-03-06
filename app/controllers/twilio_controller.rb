require 'twilio-ruby'

class SendTextController < ApplicationController
  def index
  end 

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = ""
    twilio_token = ""
    twilio_phone_number = ""

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}", 
      :to => number_to_send_to,
      :body => "This is a message. It gets sent to #{number_to_send_to}"
      )
  end 
end 
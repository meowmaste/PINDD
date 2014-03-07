class TextNotification
  def initialize message: nil, group: nil, created_by: nil
    @msg = message
    @group = group
    @created_by = created_by
    @twilio_client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"]
  end

  def send_text
    jro = User.find_by(email:'joslyn@example.com')
    lil = User.find_by(email: ENV["TWILIO_LILE"])

    if jro.groups.include?(@group) && jro != @created_by
      @twilio_client.account.sms.messages.create(
        :from => "+1#{ENV["TWILIO_NUMBER"]}", 
        :to => ENV["TWILIO_JROS"],
        :body => @msg
      )
    end

    if lil.present? && lil.groups.include?(@group) && lil != @created_by
      @twilio_client.account.sms.messages.create(
        :from => "+1#{ENV["TWILIO_NUMBER"]}", 
        :to => ENV["TWILIO_LIL"],
        :body => @msg
      )
    end
  end
end
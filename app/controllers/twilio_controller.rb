require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  def text
    response = Twilio::TwiML::Response.new do |r|
      r.say 'Hey there. Twilio Integration with Rails 4'
    end 
  end 
end
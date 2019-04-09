class WelcomeController < ApplicationController
  def index
  end

  def send_mail
    WelcomeMailer.welcome_email.deliver_now
    render :text => "Mail sent"
  end
end

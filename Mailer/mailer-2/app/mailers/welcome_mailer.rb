class WelcomeMailer < ApplicationMailer
  def welcome_email
    mail(to: 'nguyen.quang.minh@vn.oro.com', subject: 'Email Ruby System', message: 'Hello Minh')
  end
end

class UserMailer < ApplicationMailer
  
  default to: ['quangminhit94@gmail.com'],
          bcc: ['quangminhit94@gmail.com'],
          from: 'notifications@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'https://www.gmail.com'

    # @user = params[:user]
    # @url  = user_url(@user)
    # delivery_options = { user_name: 'quangminhit94@gmail.com',
    #                      password: 'Zero2017',
    #                      address: 'localhost:3000' }
    # mail(to: @user.email,
    #      subject: "Please see the Terms and Conditions attached",
    #      delivery_method_options: delivery_options)
    
    attachments['dulich.pdf'] = File.read("#{Rails.root.to_s + '/app/assets/images/dulich.pdf'}")
    attachments['test.jpg'] = File.read("#{Rails.root.to_s + '/app/assets/images/galang1.jpg'}")
    attachments.inline['image.jpg'] = File.read("#{Rails.root.to_s + '/app/assets/images/galang1.jpg'}")


    # encoded_content = SpecialEncode(File.read("#{Rails.root.to_s + '/app/assets/images/galang1.jpg'}"))
    # attachments['galang1.jpg'] = {
    #   mime_type: 'image/jpeg',
    #   encoding: 'Base64',
    #   content: encoded_content
    # }
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
    # mail(to: email_with_name,
    #   body: params[:email_body],
    #   content_type: "text/plain",
    #   subject: "Already rendered!")
  end

  def welcome_email_inline
    @user = params[:user]
    @url  = 'https://www.gmail.com'
    attachments.inline['image.jpg'] = File.read("#{Rails.root.to_s + '/app/assets/images/galang1.jpg'}")
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end

  def welcome_email_endcode_file
    @user = params[:user]
    @url  = 'https://www.gmail.com'
    encoded_content = SpecialEncode(File.read("#{Rails.root.to_s + '/app/assets/images/galang1.jpg'}"))
    attachments['galang1.jpg'] = {
      mime_type: 'image/jpeg',
      encoding: 'Base64',
      content: encoded_content
    }
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end

  def welcome_email_other_template
    @user = params[:user]
    @url  = 'https://www.gmail.com'
    t @user
    
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, 
          subject: 'Welcome to My Awesome Site') do |format|
            format.html {render 'sample_email'}
            format.text {render plain: 'render text'}
    end
  end

  def welcome_email_with_delivery_options
    @user = params[:user]
    @url  = 'https://www.gmail.com'
    
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    delivery_options = { user_name: 'quangminhit94',
                         password: 'Zero2017',
                         address: 'example.com' }
    mail(to: @user.email,
         subject: "Please see the Terms and Conditions attached",
         delivery_method_options: delivery_options) do |format|
          format.html {render 'sample_email'}
          format.text {render plain: 'render text'}
    end
  end

  def welcome_email_without_template
    @user = params[:user]
    @url  = 'https://www.gmail.com'
    
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name,
      body: params[:email_body],
      content_type: "text/html",
      subject: "Already rendered!") do |format|
        format.html {render 'sample_email'}
        format.text {render plain: 'render text'}
    end
  end
  
  # def welcome_email_without_template
  #   @user = params[:user]
  #   @url  = 'https://www.gmail.com'
    
  #   email_with_name = %("#{@user.name}" <#{@user.email}>)
  #   mail(to: email_with_name,
  #     body: params[:email_body],
  #     content_type: "text/html",
  #     subject: "Already rendered!") do |format|
  #       format.html {render 'sample_email'}
  #       format.text {render plain: 'render text'}
  #   end
  # end

  def receive(email)
    
    page = Page.find_by(address: email.to.first)
    page.emails.create(
      subject: email.subject,
      body: email.body
    )
 
    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          file: attachment,
          description: email.subject
        })
      end
    end
  end





  # before_action { @inviter, @invitee = params[:inviter], params[:invitee] }
  # before_action { @account = params[:inviter].account }
 
  # default to:       -> { @invitee.email_address },
  #         from:     -> { common_address(@inviter) },
  #         reply_to: -> { @inviter.email_address_with_name }
 
  # def account_invitation
  #   mail subject: "#{@inviter.name} invited you to their Basecamp (#{@account.name})"
  # end
 
  # def project_invitation
  #   @project    = params[:project]
  #   @summarizer = ProjectInvitationSummarizer.new(@project.bucket)
 
  #   mail subject: "#{@inviter.name.familiar} added you to a project in Basecamp (#{@account.name})"
  # end
end

class ApplicationController < ActionController::Base
  # To go http://localhost:3000?locale=en we must setup this
  before_action :set_locale

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  def set_locale
    I18n.locale = extract_locale_from_tld || I18n.default_locale
  end
  # def set_locale
  #   I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  # end
   
  # Get locale from top-level domain or return +nil+ if such locale is not available
  # You have to put something like:
  #   127.0.0.1 application.com
  #   127.0.0.1 application.it
  #   127.0.0.1 application.pl
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    p parsed_locale.inspect
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  def default_url_options
    { locale: I18n.locale }
  end
end

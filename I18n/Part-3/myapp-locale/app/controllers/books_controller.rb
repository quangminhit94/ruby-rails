class BooksController < ApplicationController
  def index
    p flash.class.name
    
    p flash
    flash[:notice] = t(:hello_world)
    flash[:msg] = t(:msg)
    flash[:right] = I18n.t 'success.true'
    # @product = 10
    p flash
    p request.env['PATH_INFO']
    # APP_CONFIG[:deutsch_website_url] = 'http://127.0.0.1:3000/'
    # p APP_CONFIG[:deutsch_website_url]
  end

  def import
    p 'test'
  end

  # def show get
  # def edit get 
  # submit form def update post
  # process, no save new data, sau do redirect ve def show (get)), update message vao flash

end

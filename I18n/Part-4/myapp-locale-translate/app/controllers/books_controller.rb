class BooksController < ApplicationController
  def index
    flash[:notice] = t(:hello_world)
    flash[:msg] = t(:msg)
    flash[:right] = I18n.t 'success.true'
    # @product = 10
  end
end

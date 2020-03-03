class ContactsController < ApplicationController
  def index
    puts params.permit(:page)
    @contacts = Contact.order(:name).page(params[:page])
  end

end

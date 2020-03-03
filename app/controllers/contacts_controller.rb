class ContactsController < ApplicationController
  def index
    if params[:group_id] && !params[:group_id].empty?
      @contacts = Contact.order(:name).where(group_id: params[:group_id]).page(params[:page])
    else
      @contacts = Contact.order(:name).page(params[:page])
    end
  end

  def new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Contact was successfully created"
      redirect_to contact_path
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :company: :address, :phone, :group_id)
  end
  
end

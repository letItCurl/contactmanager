class ContactsController < ApplicationController

  before_action :find_contact, only: [:edit, :update, :destroy]

  def index
    if params[:group_id] && !params[:group_id].empty?
      @contacts = Contact.order(:name).where(group_id: params[:group_id]).page(params[:page])
    else
      @contacts = Contact.order(:name).page(params[:page])
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.image_derivatives! if @contact.image_data
    if @contact.save
      flash[:success] = "Contact was successfully created"
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      if params[:contact][:image] != ""
        @contact.image_derivatives! 
        @contact.save 
      end
      flash[:success] = "Contact was successfully updated"
      redirect_to contacts_path
    else
      render 'edit'
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = "Contact was successfully updated"
    redirect_to contacts_path
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :company, :address, :phone, :group_id, :image)
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end
  
end

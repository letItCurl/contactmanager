class ContactsController < ApplicationController
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
    if @contact.save
      flash[:success] = "Contact was successfully created"
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    p "======"
    p contact_params.inspect 
    p "======"
    if @contact.update(contact_params)
      flash[:success] = "Contact was successfully updated"
      redirect_to contacts_path
    else
      render 'edit'
    end

  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :company, :address, :phone, :group_id, :image)
  end
  
end

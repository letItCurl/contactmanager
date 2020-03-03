Rails.application.routes.draw do
  get 'contacts/index', as: 'contacts'
  get 'contacts/new', as: 'new_contact'
  root 'contacts#index'
end

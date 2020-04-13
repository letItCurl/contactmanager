Rails.application.routes.draw do
  get 'dashboard/index'
  root 'home#index'
  devise_for :users, controllers: {registrations: :custom_registrations}
  post 'groups/create'
  #get 'contacts/index', as: 'contacts'
  #get 'contacts/new', as: 'new_contact'
  #get 'contacts/:id/edit', to: 'contacts#edit', as: 'edit_contact'
  #patch 'contacts/:id/update', to: 'contacts#update', as: 'update_contact'
  #post '/contacts/create'
  #delete 'contacts/:id/destroy', to: 'contacts#destroy', as: 'destroy_contact'
  resources :contacts, except: [ :show ] do
    get 'autocomplete', on: :collection
  end
  
end

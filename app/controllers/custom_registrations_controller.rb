class CustomRegistrationsController < Devise::RegistrationsController
    protected

    def after_update_path_for(resource)
        contacts_path
    end
end

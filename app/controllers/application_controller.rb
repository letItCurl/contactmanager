class ApplicationController < ActionController::Base
    include Pundit
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    protected
    def after_sign_in_path_for(resource)
        stored_location_for(resource) || dashboard_index_path
    end
    def after_sign_up_path_for(resource)
        after_sign_in_path_for(resource)
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
    def user_not_authorized
        flash[:danger] = "What a naughty person you are!!!"
        redirect_to action: :index
    end
end
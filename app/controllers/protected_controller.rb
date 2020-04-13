class ProtectedController < ApplicationController
    before_action :auth

    private
    def auth
        if !user_signed_in?
            redirect_to new_user_registration_path
        end
    end
end

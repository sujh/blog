class ApplicationController < ActionController::Base

  private

    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end

end

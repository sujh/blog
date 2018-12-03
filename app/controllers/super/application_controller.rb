module Super

  class ApplicationController < ::ApplicationController

    before_action :require_admin_except_login_page

    private

      def require_admin_except_login_page
        if params[:controller] != 'super/sessions' && !current_admin
          session[:referer] = request.url
          redirect_to super_sign_path, alert: 'You are not signed in!'
        end
      end

  end

end
module Super

  class ApplicationController < ::ApplicationController

    include Pundit

    before_action :require_admin_except_login_page
    helper_method :current_admin

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

      def current_admin
        @current_admin ||= Admin.find_by(id: session[:admin_id])
      end

      def require_admin_except_login_page
        if params[:controller] != 'super/sessions' && !current_admin
          session[:referer] = request.url
          redirect_to super_sign_path, alert: 'You are not signed in!'
        end
      end

      def user_not_authorized
        render plain: '无访问权限', status: 403
      end

      def load_resource(**options)
        if options[:class] && options[:instance_name]
          resource_class = options[:class]
          inst_var_name = options[:instance_name]
        else
          resource_name = self.class.to_s.demodulize.split('Controller')[0].singularize
          resource_class = options[:class] || resource_name.constantize
          inst_var_name = options[:instance_name] || resource_name.underscore
        end
        self.instance_variable_set("@#{inst_var_name}", resource_class.find_by(id: params[:id]) || resource_class.new)
      end

      alias_method :current_user, :current_admin

  end

end
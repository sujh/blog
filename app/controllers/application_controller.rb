class ApplicationController < ActionController::Base

  private

    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
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

end

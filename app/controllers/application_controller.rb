class ApplicationController < ActionController::Base

  class << self

    def load_resource(**options)
      resource_class = options[:class] || self.to_s.demodulize.split('Controller')[0].singularize.constantize
      inst_var_name = options[:instance_name] || self.to_s.demodulize.split('Controller')[0].singularize.underscore
      class_eval do
        define_method :_load_resource do
          self.instance_variable_set("@#{inst_var_name}", resource_class.find_by(id: params[:id]) || resource_class.new)
        end
      end
      self.before_action :_load_resource, options.slice(:only, :except)
    end

  end

  private

    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end

end

class SessionsController < ApplicationController

  layout 'login'

  def create
    admin = Admin.find_by(name: params[:name])
    if admin && admin.authenticated?(params[:password])
      session[:admin_id] = admin.id
      redirect_to posts_path, notice: 'Success'
    else
      flash.now[:alert] = 'Failed: name and password do not match'
      render :new
    end
  end

end

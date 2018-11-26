class SessionsController < ApplicationController

  layout 'login'

  def create
    admin = Admin.find_by(name: params[:name])
    if admin && admin.authenticated?(params[:password])
      session[:admin_id] = admin.id
      flash.now[:success] = 'success'
      redirect_to new_post_path
    else
      flash.now[:danger] = 'Failed: name and password do not match'
      render :new
    end
  end

end

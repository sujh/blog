module Super

  class SessionsController < Super::ApplicationController

    layout 'login'

    def create
      admin = Admin.find_by(name: params[:name])
      if admin&.authenticated?(params[:password])
        sign_in(admin.id)
      else
        flash.now[:alert] = 'Failed: name and password do not match'
        render :new
      end
    end

    def destroy
      session.destroy
      redirect_to super_sign_path
    end

    private

      def sign_in(id)
        session[:admin_id] = id
        redirect_to session[:referer] || super_posts_path
        session.delete(:referer)
      end

  end

end
module Super

  class SessionsController < Super::ApplicationController

    layout 'login'

    before_action :init_session, only: [:create, :destroy]

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
      @session.destroy
      redirect_to super_sign_path
    end

    private

      def sign_in(id)
        reset_session
        @session.save(id)
        redirect_to @session[:referer] || super_posts_path
        @session.delete(:referer)
      end

      def init_session
        @session = Session.new(session)
      end

  end

end
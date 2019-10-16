module Super

  class AdminsController < Super::ApplicationController

    def edit
      @admin = authorize current_admin
    end

    def update
      @admin = authorize current_admin
      if @admin.update(admin_params)
        redirect_to edit_super_admin_path, notice: 'Success'
      else
        flash.now[:alert] = "Failed: #{@admin.full_error_messages}"
        render :edit
      end
    end

    private

      def admin_params
        params.require(:admin).permit(:name, :email, :city, :introduction, :occupation, :skills, :avatar)
      end

  end

end
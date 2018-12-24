module Super

  class PostTrashesController < ApplicationController

    before_action -> { load_resource(class: Post) }, only: [:renew, :destroy]

    def index
      @post_trashes = Post.deleted.order(deleted_at: 'desc').page(params[:page])
    end

    def destroy
      @post_trash.destroy
      redirect_to super_post_trashes_path, notice: 'Success'
    end

    def renew
      @post_trash.renew
      redirect_to super_post_trashes_path, notice: 'Success'
    end

  end

end

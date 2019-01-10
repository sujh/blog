module Super

  class PostsController < ApplicationController

    before_action :load_resource, only: [:show, :edit, :update, :destroy, :new]

    def index
      @query = params[:q]
      if @query.present?
        @posts = Post.search(@query).records.undeleted.page(params[:page])
      else
        @posts = Post.undeleted.order(id: 'desc').page(params[:page])
      end
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        PostDraft.find_by(id: params[:post_draft_id]).destroy if params[:post_draft_id].present?
        redirect_to super_posts_path, notice: 'Success'
      else
        flash.now[:alert] = "Failed: #{@post.full_error_messages}"
        render :new
      end
    end

    def update
      if @post.update(post_params)
        @post.draft&.destroy
        redirect_to(super_posts_path, notice: 'Success')
      else
        flash.now[:alert] = "Failed: #{@post.full_error_messages}"
        render :edit
      end
    end

    def destroy
      @post.act_as_deleted
      redirect_to super_posts_path, notice: 'Success'
    end

    def preview
      render plain: MkRenderer.render(params[:content])
    end

    private

      def post_params
        params.require(:post).permit(:title, :content)
      end

  end

end
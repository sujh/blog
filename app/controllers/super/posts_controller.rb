module Super

  class PostsController < ApplicationController

    before_action :load_resource, only: [:show, :edit, :update, :destroy, :new]

    def index
      @posts =
        if params[:value].present?
          current_admin.posts.with_tag(params[:value])
        else
          current_admin.posts
        end.order(id: 'desc').page(params[:page])
    end

    def new
      @post.tags.build
    end

    def create
      @post = current_admin.posts.new(post_params)
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
      @post.destroy
      redirect_to super_posts_path, notice: 'Success'
    end

    def preview
      render plain: MkRenderer.render(params[:content])
    end

    private

      def post_params
        params.require(:post).permit(:title, :content, tags_attributes: [:id, :value, :_destroy])
      end

  end

end
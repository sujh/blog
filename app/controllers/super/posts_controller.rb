module Super

  class PostsController < ApplicationController

    load_resource only: [:show, :edit, :update, :destroy, :new]

    def index
      @posts = Post.undeleted.order(id: 'desc').page(params[:page])
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        clear_draft
        redirect_to super_posts_path, notice: 'Success'
      else
        flash.now[:alert] = "Failed: #{@post.full_error_messages}"
        render :new
      end
    end

    def update
      if @post.update(post_params)
        clear_draft
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

      #若用callback来删除draft，则使用@draft.create_post时会报错，因为在create_post过程中，会删除@draft，再对@draft的外键属性赋值，
      #但此时@draft已经被删除，各种属性被冻结
      def clear_draft
        @draft = @post.draft
        @draft ? @draft.destroy : PostDraft.find_by(id: params[:post_draft_id])&.destroy
      end

  end

end
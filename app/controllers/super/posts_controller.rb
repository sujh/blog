module Super

  class PostsController < ApplicationController

    before_action :load_post, only: [:show, :edit, :update, :destroy]

    def index
      @posts = Post.order(id: 'desc')
    end

    def new
      @post = Post.new
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
      @post.destroy!
      redirect_to super_posts_path, notice: 'Success'
    end

    def preview
      render plain: MkRenderer.render(params[:content])
    end

    private

      def post_params
        params.require(:post).permit(:title, :content)
      end

      def load_post
        @post = Post.find(params[:id])
      end

      #若用callback来删除draft，则使用@draft.create_post时会报错，因为在create_post过程中，会删除@draft，再对@draft的外键属性赋值，
      #但此时@draft已经被删除，各种属性被冻结
      def clear_draft
        @draft = @post.draft
        @draft ? @draft.destroy : PostDraft.find_by(id: params[:post_draft_id])&.destroy
      end

  end

end
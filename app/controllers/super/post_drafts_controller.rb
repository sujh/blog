module Super

  class PostDraftsController < ApplicationController

    before_action :load_draft, only: [:edit, :destroy, :publish]

    def index
      @drafts = PostDraft.all
    end

    def preserve
      draft_id = draft_params.extract!(:draft_id)[:draft_id]
      code, msg, data = -1, 'fail', {}
      if draft_id.present?
        @draft = PostDraft.find(draft_id)
        code, msg, data = 100, 'Done', { post_draft_id: @draft.id } if @draft.update(draft_params)
      else
        @draft = PostDraft.create(draft_params)
        code, msg, data = 100, 'Done', { post_draft_id: @draft.id } if @draft.persisted?
      end
      render json: { code: code, msg: msg, data: data }
    end

    def publish
      if create_or_update_post
        @draft.destroy
        redirect_to super_posts_path, notice: 'Success'
      else
        flash.now[:alert] = "Failed: #{@post.full_error_messages}"
        render :edit
      end
    end

    def destroy
      @draft.destroy
      redirect_to super_post_drafts_path, notice: 'Success'
    end

    private

      def draft_params
        @draft_params ||=
          if request.xhr?
            params.slice(:title, :content, :draft_id, :post_id).permit!
          else
            params.require(:post_draft).permit(:title, :content)
          end
      end

      def load_draft
        @draft = PostDraft.find(params[:id])
      end

      def create_or_update_post
        @post = @draft.post
        @post ? @post.update(draft_params) : @draft.create_post(draft_params)
      end

  end

end
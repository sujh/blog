module Super

  class TagsController < ApplicationController

    before_action :load_resource, only: [:show]

    def show
      @posts = @tag.posts.page(params[:page])
    end

  end

end
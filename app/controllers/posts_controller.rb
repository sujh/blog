class PostsController < ApplicationController

  def index
    @posts = Post.order(id: 'desc')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Success'
    else
      flash.now[:alert] = "Failed: #{@post.full_error_messages}"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to(posts_path, notice: 'Success')
    else
      flash.now[:alert] = "Failed: #{@post.full_error_messages}"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path, notice: 'Success'
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

end
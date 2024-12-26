class PostsController < ApplicationController
   before_action :authorize_user, only: [:edit, :update]
   before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    set_post
     # @comment = @post.comments.new
  end

  def edit
   @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path, alert: 'You cannot edit someone else\'s post.'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])  # Use `find_by` to handle the case when the post is not found
    if @post.nil?
      flash[:alert] = "Post not found"
      redirect_to posts_path  # Redirect to the posts list if the post is not found
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

end

class CommentsController < ApplicationController
   before_action :set_post
  def index
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def create
  	@comment = @post.comments.new(comment_params.merge(user: current_user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
   end

  def destroy
     @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end

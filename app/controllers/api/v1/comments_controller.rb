class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_post
  before_action :set_comment, only: %i[update destroy]

  def index
    render json: @post.comments, status: :ok
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_api_v1_user.id
    if @comment.save
      render json: { message: 'Created successfully', data: @comment }, status: :created
    else
      render json: { message: 'Unable to create', data: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: { message: 'Updated successfully', data: @comment }, status: :ok
    else
      render json: { message: 'Unable to update', data: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      render json: { message: 'Deleted successfully' }, status: :ok
    else
      render json: { message: 'Unable to delete', data: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end
end

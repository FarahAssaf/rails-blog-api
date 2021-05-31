class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def show
    render json: @post, status: :ok
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: { message: 'Created successfully', data: @post }, status: :created
    else
      render json: { message: 'Unable to create', data: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: { message: 'Updated successfully', data: @post }, status: :ok
    else
      render json: { message: 'Unable to update', data: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { message: 'Deleted successfully' }, status: :ok
    else
      render json: { message: 'Unable to delete', data: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

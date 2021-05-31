class ReactionsController < ApplicationController
  before_action :set_comment

  def create
    @reaction = @comment.reactions.build(comment_params)
    @reaction.user_id = current_user.id
    if @reaction.save
      render json: { message: 'Created successfully', data: @reaction }, status: :created
    else
      render json: { message: 'Unable to create', data: @reaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @reaction = @comment.reactions.find(params[:id])
    if @reaction.destroy
      render json: { message: 'Deleted successfully' }, status: :ok
    else
      render json: { message: 'Unable to delete', data: @reaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Post.find(params[:post_id])
  end

  def set_reaction
    @reaction = @comment.reactions.find(params[:id])
  end
end

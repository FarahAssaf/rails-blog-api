class Api::V1::ReactionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_comment
  before_action :set_reaction, only: :destroy
  before_action :owned_reaction, only: %i[update destroy]

  def create
    @reaction = @comment.reactions.build(reaction_params)
    @reaction.user_id = current_api_v1_user.id
    if @reaction.save
      render json: { message: 'Created successfully', data: @reaction }, status: :created
    else
      render json: { message: 'Unable to create', data: @reaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @reaction.destroy
      render json: { message: 'Deleted successfully' }, status: :ok
    else
      render json: { message: 'Unable to delete', data: @reaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:emote)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_reaction
    @reaction = @comment.reactions.find(params[:id])
  end

  def owned_reaction
    return if @reaction.user_id == current_api_v1_user.id

    render json: { message: 'Unable to proceed' }, status: :unprocessable_entity
  end
end

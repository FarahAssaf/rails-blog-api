class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from("comment_channel_#{params[:comment_id]}") if params[:comment_id].present?
  end
end

class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from("post_channel_#{params[:post_id]}") if params[:post_id].present?
  end
end

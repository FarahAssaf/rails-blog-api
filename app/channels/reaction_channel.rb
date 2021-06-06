class ReactionChannel < ApplicationCable::Channel
  def subscribed
    stream_from("reaction_channel_#{params[:reaction_id]}") if params[:reaction_id].present?
  end
end

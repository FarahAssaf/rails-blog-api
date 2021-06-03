class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def posts
    user = User.find(params[:id])
    render json: user.posts, status: :ok
  end
end

class UsersController < ApplicationController
  def posts
    user = User.find(params[:id])
    render json: user.posts, status: :ok
  end
end

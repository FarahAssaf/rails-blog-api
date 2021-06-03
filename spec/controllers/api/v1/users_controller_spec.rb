require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:api_version)  { '/api/v1/' }
  let(:user)         { create(:user) }
  let(:second_user)  { create(:user) }
  let(:blog_post)    { create(:post, user: user, body: 'Nice stuff.') }
  let(:second_post)  { create(:post, user: second_user, body: 'Nice stuff 2.') }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /users/:id/posts' do
    before do
      blog_post
      second_post
      get "#{api_version}users/#{user.id}/posts", headers: auth_headers
    end

    it 'returns status success' do
      expect(response).to have_http_status :success
    end

    it 'returns only the posts created by given user' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.map { |record| record['id'] }).to eq([blog_post.id])
    end
  end
end

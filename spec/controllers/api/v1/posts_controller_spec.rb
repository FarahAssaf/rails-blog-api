require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  let(:api_version)  { '/api/v1/' }
  let(:user)         { create(:user) }
  let(:second_user)  { create(:user) }
  let(:blog_post)    { create(:post, user: user, body: 'Nice stuff.') }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /posts/:id' do
    before do
      get "#{api_version}posts/#{blog_post.id}", headers: auth_headers
    end

    it 'returns status success' do
      expect(response).to have_http_status :success
    end

    it 'returns the post record' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json['id']).to eq(blog_post.id)
    end
  end

  describe 'POST /posts' do
    before { post "#{api_version}posts", params: { post: { body: 'Yay!' } }, headers: auth_headers }

    context 'Valid' do
      it 'creates post' do
        expect(Post.all.size).to eq(1)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'PATCH /posts/:id' do
    context 'Valid' do
      before do
        blog_post
        patch "#{api_version}posts/#{blog_post.id}", params: { post: { body: 'Yay!' } }, headers: auth_headers
      end

      it 'updates post' do
        blog_post.reload
        expect(blog_post.body).to eq('Yay!')
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end

    context 'post does not belong to current_user' do
      it 'should not update' do
        blog_post
        patch "#{api_version}posts/#{blog_post.id}", params: { post: { body: 'Yay!' } }, headers: second_user.create_new_auth_token
        blog_post.reload
        expect(blog_post.body).not_to eq('Yay!')
      end
    end
  end

  describe 'DELETE /posts/:id' do
    context 'Valid' do
      before do
        blog_post
        delete "#{api_version}posts/#{blog_post.id}", headers: auth_headers
      end

      it 'destroys post' do
        expect(Post.all.size).to eq(0)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end

    context 'post does not belong to current_user' do
      it 'should not delete' do
        blog_post
        delete "#{api_version}posts/#{blog_post.id}", headers: second_user.create_new_auth_token
        expect(Post.all.size).to eq(1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  let(:uri)            { "/api/v1/posts/#{blog_post.id}/comments" }
  let(:user)           { create(:user) }
  let(:second_user)    { create(:user) }
  let(:blog_post)      { create(:post, user: user, body: 'Nice stuff.') }
  let(:second_post)    { create(:post, user: second_user, body: 'Nice stuff 2.') }
  let(:comment)        { create(:comment, user: user, post: blog_post) }
  let(:second_comment) { create(:comment, user: user, post: second_post) }
  let(:reaction)       { create(:reaction, user: user, comment: comment) }
  let(:auth_headers)   { user.create_new_auth_token }

  describe 'GET /posts/:post_id/comments' do
    before do
      reaction
      second_comment
      get uri, headers: auth_headers
    end

    it 'returns status success' do
      expect(response).to have_http_status :success
    end

    it 'returns the comments only on the post given with their reactions' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.map { |record| record['id'] }).to eq([comment.id])
      expect(json.first['reactions'].map { |reaction| reaction['id'] }).to eq([reaction.id])
    end
  end

  describe 'POST /posts/:post_id/comments' do
    before { post uri, params: { comment: { body: 'Yay!' } }, headers: auth_headers }

    context 'Valid' do
      it 'creates comment' do
        expect(Post.all.size).to eq(1)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'PATCH /posts/:post_id/comments/:id' do
    before do
      blog_post
      patch "#{uri}/#{comment.id}", params: { comment: { body: 'Yay!' } }, headers: auth_headers
    end

    context 'Valid' do
      it 'updates comment' do
        comment.reload
        expect(comment.body).to eq('Yay!')
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'DELETE /posts/:post_id/comments/:id' do
    before do
      blog_post
      delete "#{uri}/#{comment.id}", headers: auth_headers
    end

    context 'Valid' do
      it 'destroys comment' do
        expect(Comment.all.size).to eq(0)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end
  end
end

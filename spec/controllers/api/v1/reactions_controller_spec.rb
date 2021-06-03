require 'rails_helper'

RSpec.describe 'Reactions API', type: :request do
  let(:uri)          { "/api/v1/comments/#{comment.id}/reactions" }
  let(:user)         { create(:user) }
  let(:second_user)  { create(:user) }
  let(:blog_post)    { create(:post, user: user, body: 'Nice stuff.') }
  let(:comment)      { create(:comment, user: user, post: blog_post) }
  let(:reaction)     { create(:reaction, user: user, comment: comment) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'POST /comments/:comment_id/reactions' do
    context 'Valid' do
      before { post uri, params: { reaction: { emote: :like } }, headers: auth_headers }

      it 'creates reaction' do
        expect(Post.all.size).to eq(1)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'DELETE /comments/:comment_id/reactions/:id' do
    context 'Valid' do
      before do
        reaction
        delete "#{uri}/#{reaction.id}", headers: auth_headers
      end

      it 'destroys reaction' do
        expect(Reaction.all.size).to eq(0)
      end

      it 'returns status success' do
        expect(response).to have_http_status :success
      end
    end

    context 'reaction does not belong to current_user' do
      it 'should not delete' do
        reaction
        delete "#{uri}/#{reaction.id}", headers: second_user.create_new_auth_token
        expect(Reaction.all.size).to eq(1)
      end
    end
  end
end

RSpec.describe Comment, type: :model do
  let(:user)      { create(:user) }
  let(:blog_post) { create(:post, user: user, body: 'Nice stuff.') }
  subject         { create(:comment, user: user, post: blog_post) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:reactions).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:post_id) }
  end
end

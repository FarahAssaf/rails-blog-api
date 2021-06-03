RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:reactions).dependent(:destroy) }
  end
end

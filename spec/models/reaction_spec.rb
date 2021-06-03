RSpec.describe Reaction, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:comment) }
    it { should define_enum_for(:emote).with_values(Reaction::REACTION_TYPES.keys) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:comment_id) }
    it { is_expected.to validate_presence_of(:emote) }
  end
end

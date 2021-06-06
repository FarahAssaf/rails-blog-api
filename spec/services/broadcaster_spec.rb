require 'rails_helper'

RSpec.describe Broadcaster, type: :model do
  let(:user)      { create(:user) }
  let(:blog_post) { create(:post, user: user, body: 'Nice stuff.') }
  subject { Broadcaster.new(blog_post) }

  describe '#call' do
    it 'broadcasts to the object specified channel' do
      expect { subject.call }.to have_broadcasted_to("post_channel_#{blog_post.id}")
    end

    xit 'broadcasts to the object specified channel with payload of given object and id' do
      expect { subject.call }.to have_broadcasted_to("post_channel_#{blog_post.id}") .with({post_id: blog_post.id, content: blog_post}.to_json)
    end
  end
end

require 'rails_helper'

RSpec.describe CommentChannel, type: :channel do
  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'successfully subscribes with the correct identifer' do
    stub_connection comment_id: 42
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription.comment_id).to eq 42
  end
end

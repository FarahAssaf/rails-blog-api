require 'rails_helper'

RSpec.describe PostChannel, type: :channel do
  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'successfully subscribes with the correct identifer' do
    stub_connection post_id: 42
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription.post_id).to eq 42
  end
end

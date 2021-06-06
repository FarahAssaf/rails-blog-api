class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reactions, dependent: :destroy

  validates :user_id, :post_id, presence: true
  after_commit { Broadcaster.new(self).call }
end

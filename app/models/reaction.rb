class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, :comment_id, presence: true
  # validates :type, inclusion: { in: REACTION_TYPES.values }

  REACTION_TYPES = { like: 0, smile: 1, thumbs_up: 2 }.freeze

  enum type: REACTION_TYPES
end

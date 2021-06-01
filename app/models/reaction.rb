class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, :comment_id, :emote, presence: true

  REACTION_TYPES = { like: 0, smile: 1, thumbs_up: 2 }.freeze

  enum emote: REACTION_TYPES
end

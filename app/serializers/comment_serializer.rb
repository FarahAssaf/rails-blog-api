class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body

  has_many :reactions
end

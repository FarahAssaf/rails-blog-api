class Broadcaster
  attr_accessor :object

  def initialize(object)
    @object = object
  end

  def call
    return unless object.present?

    object_type = object.class.name.downcase
    payload = {
      "#{object_type}_id" => object.id,
      content: object
    }
    ActionCable.server.broadcast("#{object_type}_channel_#{object.id}", payload)
  end
end

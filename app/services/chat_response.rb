class ChatResponse

  def call
    chat_room.with_instructions("You are a helpful online shop assistant who provides product information and helps customers to make a purchase")
    chat_room.with_tools(
      Tools::Products::Search.new,
      Tools::Products::Select.new(chat_room_id: chat_room.id),
      Tools::Products::CheckoutCheck.new(user: chat_room.user),
      Tools::UpdateUserDetails.new(user: chat_room.user)
    )

    response = chat_room.ask message
    response
  end

  private

  attr_reader :message, :chat_room

  def initialize(message, chat_room)
    @message = message
    @chat_room = chat_room
  end

  def self.call(message:, chat_room:)
    new(message, chat_room).call
  end
end

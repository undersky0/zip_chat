class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room

  # POST /chat_rooms/:chat_room_id/messages
  def create
    @message = @chat_room.messages.create(message_params)
    #TODO: moved into a service object for better seperation and testing!
    chat = RubyLLM.chat
    chat.with_instructions("You are a helpful online shop assistant who provides product information and helps customers to make a purchase")

    chat.with_tools(AiTools::Products::GetAll.new, AiTools::Products::Select.new(chat_room_id: @chat_room.id), AiTools::Products::CheckoutCheck.new)
    #TODO: ADD ERROR HANDLING
    response = chat.ask @message.content

    @ai_message = @chat_room.messages.create(content: response.content)
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content).with_defaults(user: current_user)
  end
end

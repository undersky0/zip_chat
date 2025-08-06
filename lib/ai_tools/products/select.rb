class AiTools::Products::Select < RubyLLM::Tool
  description "Select product and add to basket - returns a confirmation message"

  param :product_id, desc: "ID of the product to select"

  def initialize(chat_room_id:)
    @chat_room = ChatRoom.find(chat_room_id)
  end

  def execute(product_id: nil)
    debugger
    # Logic to select the product and add it to the basket
    { message: "Product #{product_id} has been added to your cart." }
  end
end

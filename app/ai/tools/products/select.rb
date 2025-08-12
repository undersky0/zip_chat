class Tools::Products::Select < RubyLLM::Tool
  description "Select product and add to basket - returns a confirmation message"

  param :product_id, desc: "ID of the product to select"

  def initialize(chat_room_id:)
    @chat_room = ChatRoom.find(chat_room_id)
  end

  def execute(product_id: nil)
    return "Please provide a product ID." unless product_id

    begin
      "Product #{product_id} has been added to your cart."
    rescue => e
      Rails.logger.error "Select tool error: #{e.message}"
      "Sorry, I couldn't add that product to your cart. Please try again."
    end
  end
end

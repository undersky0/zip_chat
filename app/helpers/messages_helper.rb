module MessagesHelper
  def product_message?(message)
    message.parent_tool_call.present? && (message.parent_tool_call.name == "tools--products--search")
  end

  def message_products(message)
    JSON.parse(message.content)["products"] rescue []
  end
end

class AddModelIdToChatRoom < ActiveRecord::Migration[8.0]
  def change
    add_column :chat_rooms, :model_id, :string
  end
end

class AddToMessage < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :role, :string
    add_column :messages, :model_id, :string
    add_column :messages, :input_tokens, :integer
    add_column :messages, :output_tokens, :integer
    add_reference :messages, :tool_call, foreign_key: true
  end
end

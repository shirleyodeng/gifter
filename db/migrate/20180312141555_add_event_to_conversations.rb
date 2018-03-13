class AddEventToConversations < ActiveRecord::Migration[5.1]
  def change
    add_reference :conversations, :event, foreign_key: true
  end
end

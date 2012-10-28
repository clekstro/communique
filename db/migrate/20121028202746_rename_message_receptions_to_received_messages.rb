class RenameMessageReceptionsToReceivedMessages < ActiveRecord::Migration
  def change
    rename_table :communique_message_receptions, :communique_received_messages
  end
end

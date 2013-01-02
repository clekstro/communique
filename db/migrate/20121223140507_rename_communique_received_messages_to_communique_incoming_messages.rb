class RenameCommuniqueReceivedMessagesToCommuniqueIncomingMessages < ActiveRecord::Migration
  def up
    rename_table :communique_received_messages, :communique_incoming_messages
  end

  def down
    rename_table :communique_incoming_messages, :communique_received_messages
  end
end

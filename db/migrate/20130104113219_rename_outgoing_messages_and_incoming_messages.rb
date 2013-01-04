class RenameOutgoingMessagesAndIncomingMessages < ActiveRecord::Migration
  def up
    rename_table :communique_outgoing_messages, :communique_authored_messages
    rename_table :communique_incoming_messages, :communique_received_messages
  end

  def down
    rename_table :communique_authored_messages, :communique_outgoing_messages
    rename_table :communique_received_messages, :communique_incoming_messages
  end
end

class RenameCommuniqueMessagesToCommuniqueOutgoingMessages < ActiveRecord::Migration
  def up
    rename_table :communique_messages, :communique_outgoing_messages
  end

  def down
    rename_table :communique_outgoing_messages, :communique_messages
  end
end

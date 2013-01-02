class RemoveDraftFlagFromCommuniqueOutgoingMessages < ActiveRecord::Migration
  def up
    remove_column :communique_outgoing_messages, :draft
  end

  def down
    add_column :communique_outgoing_messages, :draft, :boolean
  end
end

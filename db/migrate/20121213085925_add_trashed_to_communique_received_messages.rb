class AddTrashedToCommuniqueReceivedMessages < ActiveRecord::Migration
  def change
    add_column :communique_received_messages, :trashed, :boolean
  end
end

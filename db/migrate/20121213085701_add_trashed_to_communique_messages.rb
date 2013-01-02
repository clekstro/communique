class AddTrashedToCommuniqueMessages < ActiveRecord::Migration
  def change
    add_column :communique_messages, :trashed, :boolean
  end
end

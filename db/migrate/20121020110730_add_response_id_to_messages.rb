class AddResponseIdToMessages < ActiveRecord::Migration
  def change
    add_column :communique_messages, :response_id, :integer
  end
end

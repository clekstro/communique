class AddTypeFieldToCommuniqueMessages < ActiveRecord::Migration
  def change
    add_column :communique_messages, :type, :string
  end
end

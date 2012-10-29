class AddRecipientsStringToMessages < ActiveRecord::Migration
  def change
    add_column :communique_messages, :recipients, :string
  end
end

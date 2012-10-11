class CreateCommuniqueMessageReceptions < ActiveRecord::Migration
  def change
    create_table :communique_message_receptions do |t|
      t.integer :message_id
      t.integer :recipient_id
      t.boolean :deleted
      t.boolean :read

      t.timestamps
    end
  end
end

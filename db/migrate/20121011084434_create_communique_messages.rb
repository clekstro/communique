class CreateCommuniqueMessages < ActiveRecord::Migration
  def change
    create_table :communique_messages do |t|
      t.integer :sender_id
      t.string :subject
      t.text :content
      t.boolean :deleted
      t.boolean :draft

      t.timestamps
    end
  end
end

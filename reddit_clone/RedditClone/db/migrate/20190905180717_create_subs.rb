class CreateSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :subs do |t|
      t.text :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false

      t.timestamps
    end
    add_index :subs, :moderator_id
  end
end
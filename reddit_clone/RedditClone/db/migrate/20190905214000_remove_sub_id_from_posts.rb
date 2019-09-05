class RemoveSubIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :sub_id
    remove_column :posts, :sub_id
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.string :title
      t.string :body, null: false

      t.timestamps
    end
    add_index :posts, :book_id
    add_index :posts, :user_id
  end
end

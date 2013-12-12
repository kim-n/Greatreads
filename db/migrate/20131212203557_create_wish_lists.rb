class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.timestamps
    end
    add_index :wish_lists, [:user_id, :book_id], unique: true
  end
end

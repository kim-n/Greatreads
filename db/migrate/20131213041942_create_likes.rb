class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.integer :taste, null: false
      
      t.timestamps
    end
    add_index :likes, [:user_id, :book_id], unique: true
  end
end



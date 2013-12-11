class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.string :title
      t.string :body, null: false

      t.timestamps
    end
     add_index :reviews, [:book_id, :user_id], unique: true
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.integer :club_id, null: false
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.string :title
      t.string :body, null: false

      t.timestamps
    end
  end
end

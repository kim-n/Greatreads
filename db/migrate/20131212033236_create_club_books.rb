class CreateClubBooks < ActiveRecord::Migration
  def change
    create_table :club_books do |t|
      t.integer :club_id, null: false
      t.integer :book_id, null: false
      t.timestamps
    end
    add_index :club_books, [:club_id, :book_id], unique: true
  end
end

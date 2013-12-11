class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false
      t.string :pic, null: false
      t.timestamps
    end
    add_index :books, :isbn, unique: true
  end
end

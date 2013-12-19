class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :club_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :memberships, [:club_id, :user_id], unique: true
  end
end

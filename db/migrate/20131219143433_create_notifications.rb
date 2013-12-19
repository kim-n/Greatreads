class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :obj_type, null: false
      t.integer :obj_id, null: false
      t.boolean :checked, default: false
      t.timestamps
    end
  end
end

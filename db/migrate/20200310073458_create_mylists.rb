class CreateMylists < ActiveRecord::Migration[6.0]
  def change
    create_table :mylists do |t|
      t.integer :user_id
      t.integer :reservation_id

      t.timestamps
    end
    add_index :mylists, :user_id
    # add_index :mylists, :reservation_id
    add_index :mylists, [:user_id, :reservation_id], unique: true
  end
end

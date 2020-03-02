class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :name
      t.datetime :start_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations, [:user_id, :start_date]
  end
end

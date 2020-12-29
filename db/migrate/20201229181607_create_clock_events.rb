class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_events do |t|
      t.integer :user_id
      t.boolean :clock_in
      t.datetime :occurred_at

      t.timestamps
    end
  end
end

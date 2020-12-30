class ChangeClockEventDateTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :clock_events, :occurred_at, :occurred_at_time
    add_column :clock_events, :occurred_at_date, :datetime
  end
end

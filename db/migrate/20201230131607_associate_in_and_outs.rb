class AssociateInAndOuts < ActiveRecord::Migration[5.2]
  def change
    add_column :clock_events, :clock_in_id, :integer
    add_column :clock_events, :clock_out_id, :integer
    add_column :clock_events, :hours_clocked, :float
  end
end

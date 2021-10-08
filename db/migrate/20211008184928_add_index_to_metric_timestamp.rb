class AddIndexToMetricTimestamp < ActiveRecord::Migration[6.1]
  def change
    add_index :metrics, :timestamp
  end
end

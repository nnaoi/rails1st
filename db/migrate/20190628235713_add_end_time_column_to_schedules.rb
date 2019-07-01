class AddEndTimeColumnToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :end_time, :datetime
  end
end

class UpdateEndTimeToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :end_time, :datetime
    add_column :schedules, :end_time, :time
  end
end

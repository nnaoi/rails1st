class UndoEndTimeToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules ,:end_time ,:time  
    add_column :schedules ,:end_time, :datetime
  end
end

class RenameSchduleIdColumnToSheduleMembers < ActiveRecord::Migration[5.2]
  def change
    rename_column :schedule_members, :schdule_id, :schedule_id
  end
end

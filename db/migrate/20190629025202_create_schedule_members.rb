class CreateScheduleMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_members do |t|
      t.integer :schdule_id
      t.integer :user_id

      t.timestamps
    end
  end
end

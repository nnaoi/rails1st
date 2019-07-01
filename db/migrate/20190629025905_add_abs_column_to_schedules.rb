class AddAbsColumnToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :abs, :string
  end
end

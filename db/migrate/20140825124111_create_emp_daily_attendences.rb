class CreateEmpDailyAttendences < ActiveRecord::Migration
  def change
    create_table :emp_daily_attendences do |t|
      t.string :employee_code
      t.date :date_time
      t.integer :actual_working_hrs
      t.integer :actual_workingMin
      t.decimal :actual_ondesk_time
      t.decimal :office_time
      t.text :comments
      t.timestamps
    end
  end
end

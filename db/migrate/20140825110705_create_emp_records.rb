class CreateEmpRecords < ActiveRecord::Migration
  def up
    create_table :emp_records, id: false do |t|
	t.string :presentcardno

      t.timestamps
    end
     execute "ALTER TABLE emp_records ADD PRIMARY KEY (presentcardno);"
  end
  def down
    drop_table :emp_records
  end
end

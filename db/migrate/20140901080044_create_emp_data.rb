class CreateEmpData < ActiveRecord::Migration
  def change
    create_table :emp_data, id: false  do |t|
      t.string :e_name
      t.string :e_code
      t.string :e_mail
      t.timestamps
    end
    execute "ALTER TABLE emp_data ADD PRIMARY KEY (e_code);"
  end
end

class EmpRecord < ActiveRecord::Base
	establish_connection(:savior721)
	self.table_name='tblemployee'
	self.primary_key = :presentcardno
	# has_many :emp_daily_attendences,:foreign_key => "employee_code"
	# has_many :temp_data,:foreign_key => "cardno"
end

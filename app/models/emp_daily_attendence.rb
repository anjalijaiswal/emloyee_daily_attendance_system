class EmpDailyAttendence < ActiveRecord::Base
	#ActiveRecord::Base.establish_connection(:development)
	# belongs_to :emp_record
	# :foreign_key =>'employee_code'
	belongs_to :emp_datum, :class_name => "EmpRecord", :foreign_key => "employee_code"
end

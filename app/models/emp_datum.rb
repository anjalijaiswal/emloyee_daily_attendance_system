class EmpDatum < ActiveRecord::Base
	#ActiveRecord::Base.establish_connection(:development)
	attr_accessible :e_name,:e_code,:e_mail
	has_many :emp_daily_attendences,:foreign_key => "employee_code"
	has_many :temp_data,:foreign_key => "cardno"

end

class TempDatum < ActiveRecord::Base
	establish_connection(:saviornew)
	self.table_name='tempdata'
	belongs_to :emp_datum, :class_name => "EmpDatum", :foreign_key => "cardno"
end

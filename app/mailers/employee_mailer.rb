class EmployeeMailer < ActionMailer::Base
  default from: "anjali.jaiswal@diaspark.com"
  
  def early_departure(per_punch,total_diff)
  	@per_punch=per_punch
  	@total=total_diff/60
  	mail(:to => "anjali.jaiswal@diaspark.com", :subject => "Early Departure")
   
  end
end

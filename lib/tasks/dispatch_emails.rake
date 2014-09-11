namespace :dispatch_emails do
  desc "TODO"
  task :e_mails => :environment do
  	#args=[]
  	args=TempDatum.where(:officepunch=>(Date.yesterday.midnight+6.hours .. Date.today.midnight+5.hours+59.minutes+59.seconds))
  	controller = EmployeesController.new
	controller.daily_attendence(args)
  end

end

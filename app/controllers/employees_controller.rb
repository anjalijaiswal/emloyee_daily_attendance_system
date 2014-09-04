class EmployeesController < ApplicationController
  def index
  end

  def daily_attendence
    punch={}
    
    # will fetch record of all employess present for yesterday
    @employees_present =TempDatum.where(:officepunch=>(Date.yesterday.midnight+6.hours .. Date.today.midnight+5.hours+59.minutes+59.seconds))
    @cardno=@employees_present.map{ |e| e.cardno}.uniq
    @cardno_cln=@cardno.select{|v|v=~/["LNO"]/}
    @cardno=@cardno-@cardno_cln
    @cardno.each do |cardno|   
        #initializing values
        total_diff=0.0
        diff=[]
        intime=[]
        outtime=[]

        @x=@employees_present.where(:cardno=>cardno)

        if @x[0].emp_datum==nil
          per_punch=[{:cardno=>cardno,:name=>nil,:in=>nil,:out=>nil,:id_no=>nil,:diff=>nil}]
        elsif @x[0].emp_datum.e_name.present?
          per_punch=[{:cardno=>cardno,:name=>@x[0].emp_datum.e_name,:in=>nil,:out=>nil,:id_no=>nil,:diff=>nil}]
        else  
          per_punch=[{:cardno=>cardno,:name=>nil,:in=>nil,:out=>nil,:id_no=>nil,:diff=>nil}]
        end
        
        
        i=0  
        while(i<(@x.size-1))
          
          #puts "#{@x[i].officepunch} ________#{@x[i].id_no}________________________________________"
          #BLOCK A AND B 12-IN 06 -OUT
          if(@x[i].id_no.strip=='12') && (@x[i+1].id_no.strip=='06')

            intime[i]=@x[i].officepunch
            outtime[i]=@x[i+1].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i]
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2
          
          #VIRTUAL OFFICE BLOCK 09-IN 03-OUT
          elsif(@x[i].id_no.strip=='09') && (@x[i+1].id_no.strip=='03')

            intime[i]=@x[i].officepunch
            outtime[i]=@x[i+1].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i]
            per_punch.append(:id_no=>@x[i+1].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2

          #MAIN BUILDING SERVER ROOM 14-IN 13-OUT
          elsif(@x[i].id_no.strip=='14') && (@x[i+1].id_no.strip=='13')
            intime[i]=@x[i].officepunch
            outtime[i]=@x[i].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i] 
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2

          #Main Building 08-IN 05-OUT
          elsif(@x[i].id_no.strip== '08') && (@x[i+1].id_no.strip=='05')
            intime[i]=@x[i].officepunch
            outtime[i]=@x[i+1].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i]
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2
         
          #C Block 04-IN 07-OUT
          elsif (@x[i].id_no.strip=='04') && (@x[i+1].id_no.strip=='07')
            intime[i]=@x[i].officepunch
            outtime[i]=@x[i+1].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i]
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2
          
          #SERVER ROOM A & B block 10-IN 11-OUT
           elsif (@x[i].id_no.strip=='10') && (@x[i+1].id_no.strip=='11')
            intime[i]=@x[i].officepunch
            outtime[i]=@x[i+1].officepunch
            diff[i]=(outtime[i]-intime[i])/60
            total_diff=total_diff+diff[i]
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>intime[i],:out=>outtime[i],:diff=>diff[i])
            i=i+2

          # combination of out case one:next is out
          elsif ['11','05','13','03','06','07'].include?(@x[i].id_no.strip) && ['11','05','13','03','06','07'].include?(@x[i+1].id_no.strip)
            diff[i]=0.000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>nil,:out=>@x[i].officepunch,:diff=>diff[i])
            per_punch.append(:id_no=>@x[i+1].id_no.strip,:in=>nil,:out=>@x[i+1].officepunch,:diff=>diff[i])
            total_diff=total_diff+diff[i]
            i=i+2

          # combination of out case two:next is in
          elsif ['11','05','13','03','06','07'].include?(@x[i].id_no.strip) &&  ['10','08','14','12','04','09'].include?(@x[i+1].id_no.strip)
            diff[i]=0.0000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>nil,:out=>@x[i].officepunch,:diff=>diff[i])
            #per_punch.append(:cardno=>cardno,:id_no=>[@x[i+1].id_no.strip],:in=>nil,:out=>outtime[i+1],:diff=>diff[i])
            total_diff=total_diff+diff[i]
            i=i+1

          #combination of in case:one next is in
          elsif ['10','08','14','12','04','09'].include?(@x[i].id_no.strip) && ['10','08','14','12','04','09'].include?(@x[i+1].id_no.strip)
            diff[i]=0.000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>@x[i].officepunch,:out=>nil,:diff=>diff[i])
            total_diff=total_diff+diff[i]
            i=i+1

          #combination of in case:two next is out
          elsif ['10','08','14','12','04','09'].include?(@x[i].id_no.strip) && ['11','05','13','03','06','07'].include?(@x[i+1].id_no.strip)
            diff[i]=0.000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>@x[i].officepunch,:out=>nil,:diff=>diff[i])
            per_punch.append(:id_no=>@x[i+1].id_no.strip,:in=>nil,:out=>@x[i+1].officepunch,:diff=>diff[i])
            total_diff=total_diff+diff[i]
            i=i+2
          #Only one record
          elsif @x.size==1 && ['10','08','14','12','04','09'].include?(@x[i].id_no.strip) 
            diff[i]=0.000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>@x[i].officepunch,:out=>nil,:diff=>diff[i])
          
          #Only one record
          elsif @x.size==1 && ['11','05','13','03','06','07'].include?(@x[i+1].id_no.strip)
            diff[i]=0.000
            per_punch.append(:id_no=>@x[i].id_no.strip,:in=>nil,:out=>@x[i].officepunch,:diff=>diff[i])

          #default
          else
            puts "NEW MACHINE"    
            diff[i]=0.0
            total_diff=total_diff+diff[i] 
            i=i+1 
          end
        
        end   
        if
          EmployeeMailer.early_departure(per_punch,total_diff).deliver 
        end 
    end
    
    #record of all employees
    @employees=EmpDatum.all
    @card=@employees.map{ |e| e.e_code}
    #eliminating janitors
    @card_cln=@card.select{|v|v=~/["LNO"]/}
    @card=@card-@card_cln 
    #finding all the absent employees
    @employee_absent=@card-@cardno
    
  end

  def create

    @employees=EmpDatum.all
  	#absent_employees(@employees,)
    #@employees=EmpRecord.find_by_sql("select presentcardno,empname,e_mail1 from tblemployee")
    @employees.each do |employee|
     if employee.e_code.present?
	   			#do nothing
      else
        EmpRecord.establish_connection
        @emp=EmpRecord.where(:presentcardno=>employee.e_code)
        EmpDatum.establish_connection
        EmpDatum.create(:e_name=> @emp.empname,:e_code=> @emp.presentcardno,:e_mail=>@emp.e_mail1)
      end
    end	
  end

  def update
  end

  def destroy
  end

end
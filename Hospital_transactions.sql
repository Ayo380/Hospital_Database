Declare @thispatient int 
Declare	@roomcap int
Declare @tempcap int
Begin tran add_patient

insert into Patient
values(3,'Ademola Akin',1234326723, '678 Halsted,Gilberts,AZ',1,31)

select @thispatient = count(*) from Patient where id = 2
select @roomcap = capacity from room where roomNum = 31
set @tempcap = @roomcap +1

IF @@ERROR <> 0
   rollback transaction add_patient
ELSE
    commit transaction add_patient


if @thispatient >1 
   begin
      rollback transaction add_patient
	  print 'This patient already exist'
	  end
else if  @tempcap > @roomcap 
   begin 
     rollback transaction add_patient
	 print 'Room is at max capacity'
	 end
else
    begin
	commit transaction add_patient
	print 'patient added successfully'
	end
--Query to create the database

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Hospital')
BEGIN
  CREATE DATABASE Hospital;
END;
GO

begin transaction
--create tables
USE hospital;


drop table if exists Payment;
drop table if exists Instruction;
drop table if exists HealthRecord;
drop table if exists Monitor;
drop table if exists Provide_medication;
drop table if exists Order_Instruction;
drop table if exists Executed_Order;
drop table if exists Instruction;
drop table if exists Physician;
drop table if exists Patient;
drop table if exists Nurse;
drop table if exists Room;


create table Room (
roomNum int primary key, 
capacity int, 
fee Money);

create table Physician (
ID int primary key, 
certification_number int, 
physician_name text, 
field_of_expertise text, 
address text, 
phone_number BIGINT);

create table Patient (
ID int primary key, 
patient_name text, 
phone_number BIGINT, 
P_Address text, 
num_night int, 
room_number int, 
foreign key(room_number) references Room(roomNum));

create table Nurse (
ID int primary key, 
nurse_name text, 
certification_number int, 
address text, 
phone_number BIGINT);

create table Payment (
patientID int primary key, 
payment_date date, 
amount int, 
foreign key(patientID) references Patient(ID));

create table Instruction (
instr_code int primary key, 
fee Money, 
instr_description text);

create table HealthRecord (
recordID int, 
patientID int, 
diseases text, 
hr_date date, 
hr_description text, 
hr_status text, 
primary key(recordID, patientID), 
foreign key(patientID) references Patient(ID));

create table Monitor (
physicianID int, 
patientID int, 
duration int,
foreign key(physicianID) references Physician(ID), 
foreign key(patientID) references Patient(ID));

create table Provide_medication (
patientID int, 
nurseID int, 
medicine_name text, 
amount int, 
foreign key(patientID) references Patient(ID), 
foreign key(nurseID) references Nurse(ID));

create table Order_Instruction (
ID int primary key, 
instruction_code int, 
physicianID int, 
patientID int, 
instr_date date, 
foreign key(instruction_code) references Instruction(instr_code), 
foreign key(patientID) references Patient(ID), 
foreign key(physicianID) references Physician(ID));

create table Executed_Order (
orderID int, 
nurseID int, 
eo_date date, 
eo_status text, 
foreign key(orderID) references Order_Instruction(ID), 
foreign key(nurseID) references Nurse(ID));

commit
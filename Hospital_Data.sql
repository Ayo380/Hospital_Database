Begin Transaction;
USE Hospital;
-- Room(roomNum int primary key, capacity int, fee double);
insert into Room VALUES
(45,58,100.45),
(34,12,67.20),
(61,98,34.87),
(78,23,35.90),
(31,26,299.23);


-- Physician(ID int primary key, certification_number int, physician_name text, field_of_expertise text, address text, phone_number BIGINT);
insert into Physician VALUES
(14, 56, 'John Doe', 'Internal Medicine', '291 Taylor Avenue, Chicago, IL', 3457890012),
(18, 23, 'Wole Soyinka', 'Neurology', '321 California Avenue, Chicago, IL', 2345111000),
(13, 31, 'Bolanle Badmus', 'Pathology','910 Arizona Street, Chicago, IL', 1812311018),
(17, 92, 'Ryan Patel', 'Psychiatry', '201 Ghana Road, Chicago, IL', 8818910222),
(2, 28, 'Jamie Carrigan', 'Pediatrics', '842 Teddy Avenue, Chicago, IL', 3613780342);

-- Patient(ID int primary key, patient_name text, phone_number BIGINT, address text, num_night int, room_number int);
insert into Patient VALUES
(5, 'Aria Shaffer' , 1112223334, '1234 Chicago Street, Bank, AZ', 3, 31),
(12, 'Sylvie Kelly' , 2221113334, '2378 Milwaukee Street, Bank, AZ', 3, 61),
(13, 'Kendra Prince' , 2312313211, '3489 Jordan Avenue, Bank, AZ', 3, 78),
(8, 'Samson Beck' , 3412894567, '231 Halsted Avenue, Bank, AZ', 3, 34),
(2, 'Elsa Bender' , 1234567890, '298 Taylor Street, Bank, AZ', 3, 45);

---- Nurse(ID int primary key, nurse_name text, certification_number int, address text, phone_number BIGINT);
insert into Nurse VALUES
(4, 'Scarlette Valencia', 56, '892 Taylor Avenue, Queens, NY', 0123457890),
(8, 'Giavanna Estrada', 23, '123 California Avenue, Queens, NY', 1110002345),
(3, 'Phoenix Ortega', 13, '190 Arizona Street, Queens, NY', 0181812311),
(7, 'Elise Noble', 92, '102 Ghana Road, Queens, NY', 2228818910),
(1, 'Joel Ray', 28, '284 Teddy Avenue, Queens, NY', 3423613780);

-- Payment(patientID int primary key, payment_date text, amount int, foreign key(patientID) references Patient(ID));
insert into Payment VALUES
(12, '2018/06/20', 321),
(5, '2017/01/11', 189),
(13, '2019/03/10', 678),
(2, '2020/03/13', 398);

-- Instruction(instr_code int primary key, fee double, instr_description text);
insert into Instruction VALUES
(65, 56.78, '2 doses every morning'),
(41, 65.87, '4 doses everyday'),
(87, 71.36, '1 dose every morning'),
(19, 43.21, '4 doses every morning'),
(21, 20.81, '3 doses everyday');

-- HealthRecord(recordID int, patientID int, diseases text, hr_date text, hr_description text, hr_status text);
insert into HealthRecord VALUES
(1, 5, 'Typhoid', '2018/07/21', 'Bad Typhoid', 'X-rays'),
(11, 12, 'Asthma', '2012/07/21', 'Need inhalers', 'Lab Test'),
(19, 13, 'Epilepsy', '2018/07/21', 'From Genetics', 'Some Allergies'),
(16, 8, 'Diabetes', '2014/07/21', 'Genetics', 'Allergies to sugar'),
(4, 2, 'Anxiety', '2018/07/21', 'Social Anxiety', 'Lab Test Results');

-- Monitor(physicianID int, patientID int, duration int);
insert into Monitor VALUES
(14, 12, 45),
(2, 2, 23),
(17, 5, 51),
(18,8, 98),
(13, 13, 11);

-- Provide_medication(patientID int, nurseID int, medicine_name text, amount int);
insert into Provide_medication VALUES
(12, 3, 'Acetaminophen', 34),
(5, 4, 'Atorvastatin', 111),
(8, 8, 'Metoprolol', 186),
(2, 1, 'Sublocade', 178),
(13, 7, 'Ibuprofen', 12 );

-- Order_Instruction(ID int primary key, instruction_code int, physicianID int, patientID int, instr_date text);
insert into Order_Instruction VALUES
(36, 65, 14, 12,'2020/04/16'),
(88, 87, 2, 5, '2021/05/17'),
(90, 41, 17, 8, '2017/02/19'),
(30, 21, 18, 2, '2021/07/11'),
(78, 19, 13, 13, '2021/11/08');

-- Executed_Order(orderID int, nurseID int, eo_date text, eo_status text);
insert into Executed_Order VALUES
(36,3,  '2018/09/11', 'PO (by mouth)'),
(30,8, '2018/02/28', 'IV (intravenous)'),
(78, 7, '2020/08/20', 'IM (intramuscular)'),
(90, 1, '2015/06/11', 'ID (intradermal)'),
(88, 4, '2015/10/17', 'PR (per rectum)');

commit
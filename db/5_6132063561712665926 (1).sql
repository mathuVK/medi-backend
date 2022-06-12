CREATE DATABASE ChannelDoctor
drop database ChannelDoctor
USE ChannelDoctor


CREATE TABLE Admin(
    Admin_id VARCHAR(6) PRIMARY KEY NOT NULL,
    Admin_type VARCHAR(30),
    Admin_Password VARCHAR(8)
 );

CREATE TABLE  Patient(
  Patient_id VARCHAR(6) PRIMARY KEY NOT NULL,
  PatientName VARCHAR(30) NOT NULL,
  NIC_or_PassportNo VARCHAR(15),
  DOB Date ,
  PatientEmail_id VARCHAR(30) NOT NULL,
  PatientPassword VARCHAR(8) NOT NULL,
  Gender VARCHAR(7),
  Profile_pic VARCHAR(10),
  HouseNo VARCHAR(5),
  Street VARCHAR(50),
  Town VARCHAR(15)
); 


CREATE TABLE  Feedback(

  Feed_id VARCHAR(5) PRIMARY KEY NOT NULL,
  Feed_date date,
  Feed_description VARCHAR(200),
  Patient_id VARCHAR(6) NOT NULL ,
  CONSTRAINT Feedback_fk FOREIGN KEY(Patient_id) REFERENCES Patient(Patient_id) ON DELETE NO ACTION 
)

CREATE TABLE Speciality(
    Speciality_id VARCHAR(6) PRIMARY KEY NOT NULL,
    Speciality_type VARCHAR(25) NOT NULL
     
)

CREATE TABLE Doctor(
    Doctor_id VARCHAR(6) NOT NULL,
    DoctorName VARCHAR(30) NOT NULL,
    DocEmail_id VARCHAR(30) NOT NULL,
    Gender VARCHAR(7),
    Profile_pic VARCHAR(10),
	Speciality_id VARCHAR(5) NOT NULL,
    Doc_description VARCHAR(200),
    CONSTRAINT Doctor_pk PRIMARY KEY(Doctor_id),
    CONSTRAINT Doctor_fk FOREIGN KEY(Speciality_id) REFERENCES Speciality(Speciality_id) ON DELETE NO ACTION 
 
)
CREATE TABLE Hospital(
    Hospital_id VARCHAR(6) NOT NULL,
    Hospitalname VARCHAR(50) NOT NULL,
	Hos_EmailId VARCHAR(30) NOT NULL,
    AddressNo VARCHAR(5),
    Street VARCHAR(50),
    Town VARCHAR(15),
    Bank_AccountNo VARCHAR(20),
	Admin_id VARCHAR(6) ,
    CONSTRAINT Hospital_pk PRIMARY KEY(Hospital_id),
    CONSTRAINT Hospital_fk FOREIGN KEY(Admin_id) REFERENCES Admin(Admin_id) ON DELETE NO ACTION ON UPDATE SET NULL
    
)

CREATE TABLE HospitalhasDoctors(
    Doctor_id VARCHAR(6) NOT NULL,
	Hospital_id VARCHAR(6) NOT NULL,
    CONSTRAINT HospitalhasDoctors_pk PRIMARY KEY(Doctor_id,Hospital_id)
)

CREATE TABLE Schedule(
    Schedule_id VARCHAR(6) NOT NULL,
    ScheduleDate DATE NOT NULL,
    ScheduleTime Time NOT NULL,
    Amount real,
	ActiveStatus VARCHAR(6) NOT NULL,
    description1 VARCHAR(200),
	Doctor_id VARCHAR(6) NOT NULL,
    Admin_id VARCHAR(6) NOT NULL,
    Hospital_id VARCHAR(6) NOT NULL, 
    CONSTRAINT Schedule_pk PRIMARY KEY(Schedule_id),
    CONSTRAINT Schedule_fk1 FOREIGN KEY(Doctor_id) REFERENCES Doctor(Doctor_id) ON DELETE NO ACTION,
	CONSTRAINT Schedule_fk2 FOREIGN KEY(Admin_id) REFERENCES Admin(Admin_id) ON DELETE NO ACTION,
	CONSTRAINT Schedule_fk3 FOREIGN KEY(Hospital_id) REFERENCES Hospital(Hospital_id) ON DELETE NO ACTION

)

CREATE TABLE BookingDetails(
    PaymentGateway_id VARCHAR(6) PRIMARY KEY NOT NULL,
	BookDate Date NOT NULL,
    Booktime Time NOT NULL,
    Schedule_id VARCHAR(6) NOT NULL,
    CONSTRAINT Booking_fk2 FOREIGN KEY(Schedule_id) REFERENCES Schedule(Schedule_id) ON DELETE NO ACTION
)

CREATE TABLE CancelBooking(
    Cancel_id VARCHAR(6) PRIMARY KEY NOT NULL,
    CancelDescription VARCHAR(250),
    PaymentGateway_id VARCHAR(6),
    CONSTRAINT CancelBooking_fk1 FOREIGN KEY(PaymentGateway_id) REFERENCES BookingDetails(PaymentGateway_id) ON DELETE NO ACTION

)


CREATE TABLE Refund(
    Refund_id VARCHAR(6) PRIMARY KEY NOT NULL,
    RefundDate DATE,
    RefundReason VARCHAR(250),
	Cancel_id VARCHAR(6),
	Patient_id VARCHAR(6) NOT NULL,
    Admin_id VARCHAR(6),  
    CONSTRAINT Refund_fk1 FOREIGN KEY(Patient_id) REFERENCES Patient(Patient_id) ON DELETE NO ACTION,
	CONSTRAINT Refund_fk2 FOREIGN KEY( Cancel_id) REFERENCES CancelBooking( Cancel_id) ON DELETE NO ACTION,
    CONSTRAINT Refund_fk3 FOREIGN KEY(Admin_id ) REFERENCES Admin(Admin_id) ON DELETE NO ACTION
)


CREATE TABLE PatientBookSchedule(
	Patient_id VARCHAR(6) NOT NULL,
	Schedule_id VARCHAR(6) NOT NULL,
    NoOfActiveBooked int,
	CONSTRAINT PatientBookSchedule_pk PRIMARY KEY(Patient_id,Schedule_id),
	CONSTRAINT PatientBookSchedule_fk1 FOREIGN KEY(Patient_id) REFERENCES Patient(Patient_id) ON DELETE NO ACTION,
	CONSTRAINT PatientBookSchedule_fk2 FOREIGN KEY(Schedule_id) REFERENCES Schedule(Schedule_id) ON DELETE NO ACTION
)

CREATE TABLE DoctorContact(
	Doctor_id VARCHAR(6) NOT NULL,
    Tp_number VARCHAR(10) NOT NULL,
    CONSTRAINT UserContact_pk PRIMARY KEY(Doctor_id,Tp_number)
)

CREATE TABLE HospitalContact(
    Hospital_id VARCHAR(6) NOT NULL,
    Tp_number VARCHAR(10) NOT NULL,
    CONSTRAINT HospitalContact_pk PRIMARY KEY(Hospital_id,Tp_number)
)
insert into Admin values('A0001','HAdmin','Wer@123');
insert into Admin values('A0002','MAdmin','ABC@123');
insert into Admin values('A0003','HAdmin','XYZ@123');
insert into Admin values('A0004','HAdmin','DAS@123');

insert into Doctor(Doctor_id, DoctorName, DocEmail_id,Gender,Speciality_id ,Doc_description) values ('D0001','Thilak Perera','thilak1@gmail.com','Male','SP001','description');
insert into Doctor(Doctor_id, DoctorName, DocEmail_id,Gender,Speciality_id ,Doc_description) value ('D0002','Jhone Palitha','jhone2@gmail.com','Male','SP002','mithuloosu');
insert into Doctor(Doctor_id, DoctorName, DocEmail_id,Gender,Speciality_id ,Doc_description) value ('D0003','Ramani Dias','thilak1@gmail.com','Female','SP003','kaja');

insert into Hospital value ('H0001','Base Hospital','bsh23@gmail.com','128/B','Johan Mawatha', 'Moratuwa', '52456552', 'A0001');
insert into Hospital value ('H0002','Colorado Hospital','coldro45@gmail.com','52/c','Elivitigala Mawatha', 'Colombo', '45869523', 'A0003');
insert into Hospital value ('H0003','Western Hospital','Wstn32@gmail.com','218','Cotta Road', 'Colombo', '88659412', 'A0004');

insert into Schedule value ('S00001','2022-06-28','08:30:00',1500.00,'Avai', 'psss2dsdj', 'D0001', 'A0001','H0001');
insert into Schedule value ('S00002','2022-06-29','07:30:00',900.00,'Avai', 'hhdghdfg5d', 'D0002','A0002', 'H0002');
insert into Schedule value ('S00003','2022-06-30','03:45:00',850.00,'Unavai', 'psss2dsdj', 'D0003','A001','H0002');

insert into Speciality value ('SP001','Pediatrics');
insert into Speciality value ('SP002','Neurology');
insert into Speciality value ('SP003','Orthopedics');

insert into HospitalhasDoctors Value('D0001','H0001');
insert into HospitalhasDoctors Value('D0002','H0001');
insert into HospitalhasDoctors Value('D0003','H0002');

SELECT d.DoctorName,h.Hospitalname,s.Speciality_type
FROM HospitalhasDoctors hd, Doctor d,Hospital h ,Speciality s
WHERE  hd.Doctor_id = d.Doctor_id and   hd.Hospital_id = h.Hospital_id and d.Speciality_id=s.Speciality_id and (d.DoctorName='Thilak Perera' or h.Hospitalname='Base Hospital' and s.Speciality_type='Pediatrics');

SELECT d.DoctorName,h.Hospitalname,s.Speciality_type,sh.ScheduleDate,sh.ScheduleTime
FROM HospitalhasDoctors hd, Doctor d,Hospital h ,Speciality s,Schedule sh
WHERE  hd.Doctor_id = d.Doctor_id=sh.Doctor_id and   hd.Hospital_id = h.Hospital_id and d.Speciality_id=s.Speciality_id (d.DoctorName='Thilak Perera' or h.Hospitalname='Base Hospital' and s.Speciality_type='Pediatrics');


SELECT* st.DoctorName
FROM Schedule st, Doctor d
WHERE st.Doctor_id =d.Doctor_id;

 
  
SELECT*
FROM Speciality






 





 

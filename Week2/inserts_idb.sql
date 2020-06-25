INSERT INTO public."Employee"(
	empno, empname, department, email, phone)
	VALUES
		('E100','Chuck Coordinator','Administration','chuck@colorado.edu','3-1111'),
		('E101','Mary Manager','Football','mary@colorado.edu','5-1111'),
		('E102','Sally Supervisor','Planning','sally@colorado.edu','3-2222'),
		('E103','Alan Administrator','Administration','alan@colorado.edu','3-3333');

INSERT INTO public."Customer"(custno,custname,address,contact,phone,city,state,zip,internal) 
	VALUES
		('C100','Football','Box 352200','Mary Manager','6857100','Boulder','CO','80309','Y'),
		('C101','Men''s Basketball','Box 352400','Sally Supervisor','5431700','Boulder','CO','80309','Y'),
		('C103','Baseball','Box 352020','Bill Baseball','5431234','Boulder','CO','80309','Y'),
		('C104','Women''s Softball','Box 351200','Sue Softball','5434321','Boulder','CO','80309','Y'),
		('C105','High School Football','123 AnyStreet','Coach Bob','4441234','Louisville','CO','80027','N');

Insert into public."ResourceTbl" (resno,resname,rate) 
	VALUES 
		('R100','attendant',10),
		('R101','police',15),
		('R102','usher',10),
		('R103','nurse',20),
		('R104','janitor',15),
		('R105','food service',10);
		
Insert into public."Facility" (FACNO,FACNAME)
	values
		('F100','Football stadium'),
		('F101','Basketball arena'),
		('F102','Baseball field'),
		('F103','Recreation room');
		
Insert into public."Location" (LOCNO,FACNO,LOCNAME)
	values
		('L100','F100','Locker room'),
		('L101','F100','Plaza'),
		('L102','F100','Vehicle gate'),
		('L103','F101','Locker room'),
		('L104','F100','Ticket Booth'),
		('L105','F101','Gate'),
		('L106','F100','Pedestrian gate');
		
Insert into public."EventRequest" (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) 
	values 
		('E100','2018-10-25','2018-06-06','C100','F100','2018-06-08','Approved',5000,80000,'B1000'),
		('E101','2018-10-26','2018-07-28','C100','F100',NULL,'Pending',5000,80000,'B1000'),
		('E103','2018-09-21','2018-07-28','C100','F100','2018-08-01','Approved',5000,80000,'B1000'),
		('E102','2018-09-14','2018-07-28','C100','F100','2018-07-31','Approved',5000,80000,'B1000'),
		('E104','2018-12-03','2018-07-28','C101','F101','2018-07-31','Approved',2000,12000,'B1000'),
		('E105','2018-12-05','2018-07-28','C101','F101','2018-08-01','Approved',2000,10000,'B1000'),
		('E106','2018-12-12','2018-07-28','C101','F101','2018-07-31','Approved',2000,10000,'B1000'),
		('E107','2018-11-23','2018-07-28','C105','F100','2018-07-31','Denied',10000,5000,null);
		
Insert into public."EventPlan" (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO)
	values
		('P100','E100','2018-10-25','Standard operation','Operation','E102'),
		('P101','E104','2018-12-03','Watch for gate crashers','Operation','E100'),
		('P102','E105','2018-12-05','Standard operation','Operation','E102'),
		('P103','E106','2018-12-12','Watch for seat switching','Operation',null),
		('P104','E101','2018-10-26','Standard cleanup','Cleanup','E101'),
		('P105','E100','2018-10-25','Light cleanup','Cleanup','E101'),
		('P199','E102','2018-12-10','ABC','Operation','E101'),
		('P299','E101','2018-10-26',NULL,'Operation','E101'),
		('P349','E106','2018-12-12',NULL,'Setup','E101'),
		('P85','E100','2018-10-25','Standard operation','Cleanup','E102'),
		('P95','E101','2018-10-26','Extra security','Cleanup','E102');
		
Insert into public."EventPlanLine" (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO)
	values
		('P100',1,'2018-10-25 08:00:00','2018-10-25 017:00:00',2,'L100','R100'),
		('P100',2,'2018-10-25 12:00:00','2018-10-25 17:00:00', 2,'L101','R101'),
		('P100',3,'2018-10-25 07:00:00','2018-10-25 16:30:00', 1,'L102','R102'),
		('P100',4,'2018-10-25 18:00:00','2018-10-25 22:00:00', 2,'L100','R102'),
		('P101',1,'2018-12-03 18:00:00','2018-12-03 20:00:00', 2,'L103','R100'),
		('P101',2,'2018-12-03 18:30:00','2018-12-03 19:00:00', 4,'L105','R100'),
		('P101',3,'2018-12-03 19:00:00','2018-12-03 20:00:00', 2,'L103','R103'),
		('P102',1,'2018-12-05 18:00:00','2018-12-05 19:00:00', 2,'L103','R100'),
		('P102',2,'2018-12-05 18:00:00','2018-12-05 21:00:00', 4,'L105','R100'),
		('P102',3,'2018-12-05 19:00:00','2018-12-05 22:00:00', 2,'L103','R103'),
		('P103',1,'2018-12-12 18:00:00','2018-12-12 21:00:00', 2,'L103','R100'),
		('P103',2,'2018-12-12 18:00:00','2018-12-12 21:00:00', 4,'L105','R100'),
		('P103',3,'2018-12-12 19:00:00','2018-12-12 22:00:00', 2,'L103','R103'),
		('P104',1,'2018-10-26 18:00:00','2018-10-26 22:00:00', 4,'L101','R104'),
		('P104',2,'2018-10-26 18:00:00','2018-10-26 22:00:00', 4,'L100','R104'),
		('P105',1,'2018-10-25 18:00:00','2018-10-25 22:00:00', 4,'L101','R104'),
		('P105',2,'2018-10-25 18:00:00','2018-10-25 22:00:00', 4,'L100','R104'),
		('P199',1,'2018-12-10 08:00:00','2018-12-10 12:00:00', 1,'L100','R100'),
		('P349',1,'2018-12-10 12:00:00','2018-12-12 15:30:00', 1,'L103','R100'),
		('P85',1,'2018-10-25 09:00:00','2018-10-25 17:00:00',  5,'L100','R100'),
		('P85',2,'2018-10-25 08:00:00','2018-10-25 17:00:00',  2,'L102','R101'),
		('P85',3,'2018-10-25 10:00:00','2018-10-25 15:00:00',  3,'L104','R100'),
		('P95',1,'2018-10-26 08:00:00','2018-10-26 17:00:00',  4,'L100','R100'),
		('P95',2,'2018-10-26 09:00:00','2018-10-26 17:00:00',  4,'L102','R101'),
		('P95',3,'2018-10-26 10:00:00','2018-10-26 15:00:00',  4,'L106','R100'),
		('P95',4,'2018-10-26 13:00:00','2018-10-26 17:00:00', 2,'L100','R103'),
		('P95',5,'2018-10-26 13:00:00','2018-10-26 17:00:00', 2,'L101','R104');
-- Database Creation

CREATE DATABASE PostGradOffice;

GO

USE PostGradOffice;

CREATE TABLE PostGradUser(
id INT PRIMARY KEY IDENTITY(1,1),
email VARCHAR(50) NOT NULL,
password VARCHAR(30) NOT NULL
);

CREATE TABLE Admin(
id INT FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GucianStudent(
id INT FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
firstName VARCHAR(20),
lastName VARCHAR(20),
type VARCHAR(3),
faculty VARCHAR(30),
address VARCHAR(50),
GPA DECIMAL(3,2),
undergradID INT,
PRIMARY KEY (id)
);

CREATE TABLE NonGucianStudent(
id INT FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
firstName VARCHAR(20),
lastName VARCHAR(20),
type VARCHAR(3),
faculty VARCHAR(30),
address VARCHAR(50),
GPA DECIMAL(3,2),
PRIMARY KEY (id)
);

CREATE TABLE GUCStudentPhoneNumber(
id INT FOREIGN KEY REFERENCES GucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
phone INT
PRIMARY KEY(id,phone)
);

CREATE TABLE NonGUCStudentPhoneNumber(
id INT FOREIGN KEY REFERENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
phone INT
PRIMARY KEY(id,phone)
);

CREATE TABLE Course(
id INT PRIMARY KEY IDENTITY(1,1),
fees INT,
creditHours INT,
code VARCHAR(10)
);

CREATE TABLE Supervisor(
id INT FOREIGN KEY REFERENCES PostGradUser,
name VARCHAR(20),
faculty VARCHAR(30),
PRIMARY KEY (id)
);

CREATE TABLE Examiner(
id INT FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
name VARCHAR(20),
fieldOfWork VARCHAR(100),
isNational BIT,
PRIMARY KEY (id)
);

CREATE TABLE Payment(
id INT PRIMARY KEY IDENTITY(1,1),
amount DECIMAL(7,2),
noOfInstallments INT,
fundPercentage DECIMAL(4,2)
);

CREATE TABLE Thesis(
serialNumber INT PRIMARY KEY IDENTITY(1,1),
field VARCHAR(20),
type VARCHAR(3) NOT NULL,
title VARCHAR(100) NOT NULL,
startDate DATE NOT NULL,
endDate DATE NOT NULL,
defenseDate DATE,
years AS (year(endDate)-year(startDate)),
grade DECIMAL(4,2),
payment_id INT FOREIGN KEY REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
noOfExtensions INT
);

CREATE TABLE Publication(
id INT PRIMARY KEY IDENTITY(1,1),
title VARCHAR(100) NOT NULL,
dateOfPublication DATE,
place VARCHAR(100),
accepted BIT,
host VARCHAR(100)
);

CREATE TABLE Defense(
serialNumber INT,
DATE DATETIME,
location VARCHAR(15),
grade DECIMAL(4,2),
PRIMARY KEY (serialNumber, DATE),
FOREIGN KEY (serialNumber) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GUCianProgressReport(
sid INT FOREIGN KEY REFERENCES GUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
no INT,
DATE DATETIME,
eval INT,
state INT,
description VARCHAR(200),
thesisSerialNumber INT FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
supid INT FOREIGN KEY REFERENCES Supervisor,
PRIMARY KEY (sid, no)
);

CREATE TABLE NonGUCianProgressReport(
sid INT FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
no INT,
DATE DATETIME,
eval INT,
state INT,
description VARCHAR(200),
thesisSerialNumber INT FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
supid INT FOREIGN KEY REFERENCES Supervisor,
PRIMARY KEY (sid, no)
);

CREATE TABLE Installment(
DATE DATETIME,
paymentId INT FOREIGN KEY REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
amount DECIMAL(8,2),
done BIT,
PRIMARY KEY (DATE, paymentId)
);

Create table NonGucianStudentPayForCourse(
sid INT FOREIGN KEY REFERENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
paymentNo INT FOREIGN KEY REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
cid INT FOREIGN KEY REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (sid, paymentNo, cid)
);

CREATE TABLE NonGucianStudentTakeCourse(
sid INT FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
cid INT FOREIGN KEY REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE,
grade DECIMAL(4,2),
PRIMARY KEY (sid, cid)
);

CREATE TABLE GUCianStudentRegisterThesis(
sid INT FOREIGN KEY REFERENCES GUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
supid INT FOREIGN KEY REFERENCES Supervisor,
serial_no INT FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE NonGUCianStudentRegisterThesis(
sid INT FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
supid INT FOREIGN KEY REFERENCES Supervisor,
serial_no INT FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE ExaminerEvaluateDefense(
DATE DATETIME,
serialNo INT,
examinerId INT FOREIGN KEY REFERENCES Examiner ON DELETE CASCADE ON UPDATE CASCADE,
comment VARCHAR(300),
PRIMARY KEY (DATE, serialNo, examinerId),
FOREIGN KEY (serialNo, DATE) REFERENCES Defense (serialNumber, DATE) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE ThesisHasPublication(
serialNo INT FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
pubid INT FOREIGN KEY REFERENCES Publication ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (serialNo, pubid)
);

--Procedures Creation:

GO

CREATE PROC studentRegister
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@faculty VARCHAR(20),
@Gucian BIT,
@email VARCHAR(50),
@address VARCHAR(50)
AS
BEGIN
INSERT INTO PostGradUser(email,password)
VALUES(@email,@password)
DECLARE @id INT
SELECT @id=SCOPE_IDENTITY()
IF(@Gucian=1)
INSERT INTO GucianStudent(id,firstName,lastName,faculty,address)
VALUES(@id,@first_name,@last_name,@faculty,@address)
ELSE
INSERT INTO NonGucianStudent(id,firstName,lastName,faculty,address)
VALUES(@id,@first_name,@last_name,@faculty,@address)
END

GO

CREATE PROC supervisorRegister
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@faculty VARCHAR(20),
@email VARCHAR(50)
AS
BEGIN
INSERT INTO PostGradUser(email,password)
VALUES(@email,@password)
DECLARE @id INT
SELECT @id=SCOPE_IDENTITY()
DECLARE @name VARCHAR(50)
SET @name=CONCAT(@first_name,@last_name)
INSERT INTO Supervisor(id,name,faculty) VALUES(@id,@name,@faculty)
END

GO

CREATE PROC examinerRegister
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@fieldOfWork VARCHAR(20),
@email VARCHAR(50),
@isNational BIT
AS
BEGIN
INSERT INTO PostGradUser(email,password)
VALUES(@email,@password)
DECLARE @id INT
SELECT @id=SCOPE_IDENTITY()
DECLARE @name VARCHAR(50)
SET @name=CONCAT(@first_name,@last_name)
INSERT INTO Examiner(id,name,fieldOfWork,isNational) VALUES(@id,@name,@fieldOfWork,@isNational)
END

GO

CREATE PROC userLogin
@email VARCHAR(50),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
DECLARE @id INT
BEGIN
IF EXISTS(
SELECT email, password
FROM PostGradUser
WHERE email=@email AND password=@password)
BEGIN
SET @success=1
SELECT @id=id
FROM PostGradUser
WHERE email=@email AND password=@password
-- Check user type: 0-->Student, 1-->Admin, 2-->Supervisor , 3-->Examiner
IF EXISTS(SELECT id FROM GucianStudent WHERE id=@id UNION SELECT id FROM
NonGucianStudent WHERE id=@id )
SET @type=0
IF EXISTS(SELECT id FROM Admin WHERE id=@id)
SET @type=1
IF EXISTS(SELECT id FROM Supervisor WHERE id=@id)
SET @type=2
IF EXISTS(SELECT id FROM Examiner WHERE id=@id)
SET @type=3
END
ELSE
SET @success=0
END

GO

CREATE PROC getSessionID
@email VARCHAR(50),
@password VARCHAR(20),
@id INT OUTPUT
AS
BEGIN
IF EXISTS(SELECT id FROM PostGradUser WHERE email=@email AND password=@password)
BEGIN
SELECT @id=id 
FROM PostGradUser 
WHERE email=@email AND password=@password
END
END

GO

CREATE PROC addMobile
@ID VARCHAR(20),
@mobile_number VARCHAR(20)
AS
BEGIN
IF @ID IS NOT NULL AND @mobile_number IS NOT NULL
BEGIN
IF(EXISTS(SELECT * FROM GucianStudent WHERE id=@ID))
INSERT INTO GUCStudentPhoneNumber VALUES(@ID,@mobile_number)
IF(EXISTS(SELECT * FROM NonGucianStudent WHERE id=@ID))
INSERT INTO NonGUCStudentPhoneNumber VALUES(@ID,@mobile_number)
END
END

GO

CREATE PROC AdminListSup
AS
SELECT u.id,u.email,u.password,s.name,s.faculty
FROM PostGradUser u INNER JOIN Supervisor s ON u.id = s.id

GO

CREATE PROC AdminViewSupervisorProfile
@supId INT
AS
SELECT u.id,u.email,u.password,s.name, s.faculty
FROM PostGradUser u INNER JOIN Supervisor s ON u.id = s.id
WHERE @supId = s.id

GO

CREATE PROC AdminViewAllTheses
AS
SELECT
serialNumber,field,type,title,startDate,endDate,defenseDate,years,grade,payment_id,noOfExtensions
FROM Thesis

GO

CREATE PROC AdminViewOnGoingTheses
@thesesCount INT output
AS
SELECT @thesesCount=Count(*)
FROM Thesis
WHERE endDate > Convert(Date,CURRENT_TIMESTAMP)

GO

CREATE PROC AdminViewStudentThesisBySupervisor
AS
SELECT s.name,t.title,gs.firstName
FROM Thesis t INNER JOIN GUCianStudentRegisterThesis sr ON t.serialNumber=sr.serial_no
INNER JOIN Supervisor s ON s.id=sr.supid INNER JOIN GucianStudent gs ON sr.sid=gs.id
WHERE t.endDate > Convert(Date,CURRENT_TIMESTAMP)
UNION
SELECT s.name,t.title,gs.firstName
FROM Thesis t INNER JOIN NonGUCianStudentRegisterThesis sr ON t.serialNumber=sr.serial_no
INNER JOIN Supervisors ON s.id=sr.supid INNER JOIN NonGucianStudent gs ON sr.sid=gs.id
WHERE t.endDate > Convert(Date,CURRENT_TIMESTAMP)

GO

CREATE PROC AdminListNonGucianCourse
@courseID INT
AS
IF(EXISTS(SELECT * FROM Course WHERE id=@courseID))
SELECT ng.firstName,ng.lastName,c.code,n.grade
FROM NonGucianStudentTakeCourse n INNER JOIN Course c ON n.cid=c.id INNER JOIN NonGucianStudent ng
ON ng.id=n.sid
WHERE n.cid=@courseID

GO

CREATE PROC AdminUpdateExtension
@ThesisSerialNo INT
AS
IF(EXISTS(SELECT * FROM Thesis WHERE serialNumber=@ThesisSerialNo))
BEGIN
DECLARE @noOfExtensions INT
SELECT @noOfExtensions=noOfExtensions FROM Thesis WHERE serialNumber=@ThesisSerialNo
UPDATE Thesis
SET noOfExtensions=@noOfExtensions+1
WHERE serialNumber=@ThesisSerialNo
END

GO

CREATE PROC AdminIssueThesisPayment
@ThesisSerialNo INT,
@amount DECIMAL,
@noOfInstallments INT,
@fundPercentage DECIMAL
AS
IF(EXISTS(SELECT * FROM Thesis WHERE serialNumber=@ThesisSerialNo))
BEGIN
INSERT INTO Payment(amount,noOfInstallments,fundPercentage)
VALUES(@amount,@noOfInstallments,@fundPercentage)
DECLARE @id INT
SELECT @id=SCOPE_IDENTITY()
UPDATE Thesis
SET payment_id=@id
WHERE serialNumber=@ThesisSerialNo
END

GO

CREATE PROC AdminViewStudentProfile
@sid INT
AS
IF(EXISTS(SELECT * FROM GucianStudent WHERE id=@sid))
SELECT u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,s.address,s.GPA
FROM PostGradUser u INNER JOIN GucianStudent s ON u.id=s.id
WHERE @sid = s.id
ELSE IF(EXISTS(SELECT * FROM NonGucianStudent WHERE id=@sid))
SELECT u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,s.address,s.GPA
FROM PostGradUser u INNER JOIN NonGucianStudent s ON u.id=s.id
WHERE @sid = s.id

GO

CREATE PROC AdminIssueInstallPayment
@paymentID INT,
@InstallStartDate date
AS
IF(EXISTS(SELECT * FROM Payment WHERE id=@paymentID))
BEGIN
DECLARE @numOfInst INT
SELECT @numOfInst=noOfInstallments
FROM Payment
WHERE id=@paymentID
DECLARE @payAmount INT
SELECT @payAmount=amount
FROM Payment
WHERE id=@paymentID
DECLARE @Counter INT
SET @Counter=1
WHILE (@counter<=@numOfInst)
BEGIN
 DECLARE @instdate date
 SET @instdate=@InstallStartDate
 DECLARE @instAmount INT
 SET @instAmount=@payAmount/@numOfInst
 IF(@counter=1)
 INSERT INTO
Installment(date,paymentId,amount,done)VALUES(@InstallStartDate,@paymentID,@instAmount,0)
 ELSE
 BEGIN
 SET @instdate=DATEADD(MM, 6, @instdate);
 INSERT INTO
Installment(date,paymentId,amount,done)VALUES(@instdate,@paymentID,@instAmount,0)
 END
 SET @counter=@counter+1
END
END

GO

CREATE PROC ViewExaminer
@id INT
AS
SELECT t.title, sup.name, s.firstName, s.lastName
FROM ExaminerEvaluateDefense ee 
INNER JOIN Defense d ON ee.serialNo = d.serialNumber AND ee.DATE = d.DATE
INNER JOIN Thesis t ON d.serialNumber = t.serialNumber
INNER JOIN GUCianStudentRegisterThesis GUC ON t.serialNumber = GUC.serial_no
INNER JOIN GucianStudent s ON GUC.sid = s.id
INNER JOIN Supervisor sup ON GUC.supid = sup.id
WHERE ee.examinerId=@id
UNION ALL
SELECT t.title, sup.name, s.firstName, s.lastName
FROM ExaminerEvaluateDefense ee 
INNER JOIN Defense d ON ee.serialNo = d.serialNumber AND ee.DATE = d.DATE
INNER JOIN Thesis t ON d.serialNumber = t.serialNumber
INNER JOIN NonGUCianStudentRegisterThesis NON ON t.serialNumber = NON.serial_no
INNER JOIN NonGucianStudent s ON NON.sid = s.id
INNER JOIN Supervisor sup ON NON.supid = sup.id
WHERE ee.examinerId=@id

GO

CREATE PROC AdminListAcceptPublication
AS
SELECT t.serialNumber,p.title
FROM ThesisHasPublication tp INNER JOIN Thesis t ON tp.serialNo=t.serialNumber
INNER JOIN Publication p ON p.id=tp.pubid
WHERE p.accepted=1

GO

CREATE PROC AddCourse
@courseCode VARCHAR(10),
@creditHrs INT,
@fees DECIMAL
AS
INSERT INTO Course VALUES(@fees,@creditHrs,@courseCode)

GO

CREATE PROC linkCourseStudent
@courseID INT,
@studentID INT
AS
IF(EXISTS(SELECT * FROM Course ) AND EXISTS(SELECT * FROM NonGucianStudent WHERE id=@studentID))
INSERT INTO NonGucianStudentTakeCourse(sid,cid,grade)VALUES(@studentID,@courseID,NULL)

GO

CREATE PROC addStudentCourseGrade
@courseID INT,
@studentID INT,
@grade DECIMAL
AS
IF(EXISTS(SELECT * FROM NonGucianStudentTakeCourse WHERE sid=@studentID AND cid=@courseID))
UPDATE NonGucianStudentTakeCourse
SET grade =@grade
WHERE cid=@courseID AND sid=@studentID

GO

CREATE PROC UpdateExaminerProfile
@id INT,
@name VARCHAR(20),
@fieldOfWork VARCHAR(100)
AS
UPDATE Examiner
SET name=@name, fieldOfWork=@fieldOfWork
WHERE id=@id

GO

CREATE PROC searchTitle
@keyword VARCHAR(100),
@success BIT OUTPUT
AS
IF EXISTS(
SELECT *
FROM Thesis
WHERE CHARINDEX(@keyword, Thesis.title) > 0)
BEGIN
SET @success = 1
SELECT *
FROM Thesis
WHERE CHARINDEX(@keyword, Thesis.title) > 0
END
ELSE
SET @success = 0

GO

CREATE PROC ViewExamSupDefense
@defenseDate DATETIME
AS
SELECT s.serial_no,ee.date,e.name,sup.name
FROM ExaminerEvaluateDefense ee INNER JOIN Examiner e ON ee.examinerId=e.id
INNER JOIN GUCianStudentRegisterThesis s ON ee.serialNo=s.serial_no
INNER JOIN Supervisor sup ON sup.id=s.supid

GO

CREATE PROC EvaluateProgressReport
@supervisorID INT,
@thesisSerialNo INT,
@progressReportNo INT,
@evaluation INT,
@success BIT OUTPUT
AS
IF(EXISTS(SELECT * FROM Thesis WHERE serialNumber=@thesisSerialNo ) AND @evaluation IN(0,1,2,3) )
BEGIN
IF(EXISTS(SELECT * FROM GUCianStudentRegisterThesis WHERE serial_no=@thesisSerialNo AND
supid=@supervisorID))
BEGIN
DECLARE @gucSid INT
SELECT @gucSid=sid
FROM GUCianStudentRegisterThesis
WHERE serial_no=@thesisSerialNo
UPDATE GUCianProgressReport
SET eval=@evaluation
WHERE sid=@gucSid AND thesisSerialNumber=@thesisSerialNo AND no=@progressReportNo
SET @success=1
END
ELSE IF(EXISTS(SELECT * FROM NonGUCianStudentRegisterThesis WHERE serial_no=@thesisSerialNo AND
supid=@supervisorID))
BEGIN
DECLARE @nonGucSid INT
SELECT @nonGucSid=sid
FROM NonGUCianStudentRegisterThesis
WHERE serial_no=@thesisSerialNo
UPDATE NonGUCianProgressReport
SET eval=@evaluation
WHERE sid=@nonGucSid AND thesisSerialNumber=@thesisSerialNo AND no=@progressReportNo
SET @success=1
END
END

GO

CREATE PROC ViewSupStudentsYears
@supervisorID INT
AS
IF(EXISTS(SELECT * FROM Supervisor WHERE id=@supervisorID))
BEGIN
SELECT s.firstName,s.lastName,t.years
FROM GUCianStudentRegisterThesis sr INNER JOIN GucianStudent s ON sr.sid=s.id
INNER JOIN Thesis t ON t.serialNumber=sr.serial_no
UNION
SELECT s.firstName,s.lastName,t.years
FROM NonGUCianStudentRegisterThesis sr INNER JOIN NonGucianStudent s ON sr.sid=s.id
INNER JOIN Thesis t ON t.serialNumber=sr.serial_no
END

GO

CREATE PROC SupViewProfile
@supervisorID INT
AS
IF(EXISTS(SELECT * FROM Supervisor WHERE id=@supervisorID))
BEGIN
SELECT u.id,u.email,u.password,s.name,s.faculty
FROM PostGradUser u INNER JOIN Supervisor s ON u.id=s.id
END

GO

CREATE PROC UpdateSupProfile
@supervisorID INT, @name VARCHAR(20), @faculty VARCHAR(20)
AS
UPDATE Supervisor
SET name = @name, faculty = @faculty
WHERE id = @supervisorID

GO

CREATE PROC ViewAStudentPublications
@StudentID INT
AS
SELECT P.*
FROM GUCianStudentRegisterThesis GUC
INNER JOIN Thesis T
ON GUC.serial_no = T.serialNumber
INNER JOIN ThesisHasPublication TP
ON T.serialNumber = TP.serialNo
INNER JOIN Publication P
ON P.id = TP.pubid
WHERE GUC.sid = @StudentID
UNION ALL
SELECT P.*
FROM NonGUCianStudentRegisterThesis NON
INNER JOIN Thesis T
ON NON.serial_no = T.serialNumber
INNER JOIN ThesisHasPublication TP
ON T.serialNumber = TP.serialNo
INNER JOIN Publication P
ON P.id = TP.pubid
WHERE NON.sid = @StudentID

GO

CREATE PROC AddDefenseGucian
@ThesisSerialNo INT , @DefenseDate DATETIME , @DefenseLocation VARCHAR(15)
AS
INSERT INTO Defense VALUES(@ThesisSerialNo,@DefenseDate,@DefenseLocation,NULL)

GO

CREATE PROC AddDefenseNonGucian
@ThesisSerialNo INT , @DefenseDate DATETIME , @DefenseLocation VARCHAR(15)
AS
DECLARE @idOfStudent INT
SELECT @idOfStudent = sid
FROM NonGUCianStudentRegisterThesis
WHERE serial_no = @ThesisSerialNo
IF(NOT EXISTS(SELECT grade
FROM NonGucianStudentTakeCourse
WHERE sid = @idOfStudent AND grade < 50))
BEGIN
INSERT INTO Defense VALUES(@ThesisSerialNo,@DefenseDate,@DefenseLocation,NULL)
END

GO

CREATE PROC AddExaminer
@ThesisSerialNo INT , @DefenseDate DATETIME , @ExaminerName VARCHAR(20),@Password VARCHAR(30),
@National BIT, @fieldOfWork VARCHAR(20)
AS
INSERT INTO PostGradUser VALUES(@ExaminerName,@Password)
DECLARE @id INT
SET @id = SCOPE_IDENTITY()
INSERT INTO Examiner VALUES(@id,@ExaminerName,@fieldOfWork,@National)
INSERT INTO ExaminerEvaluateDefense VALUES(@DefenseDate,@ThesisSerialNo,@id,NULL)

GO

CREATE PROC CancelThesis
@ThesisSerialNo INT,
@success BIT OUTPUT
AS
SET @success=0
IF(EXISTS(
SELECT *
FROM GUCianProgressReport
WHERE thesisSerialNumber = @ThesisSerialNo
))
	BEGIN
	DECLARE @gucianEval INT
	SET @gucianEval = (
	SELECT TOP 1 eval
	FROM GUCianProgressReport
	WHERE thesisSerialNumber = @ThesisSerialNo
	ORDER BY no DESC
	)
	IF(@gucianEval = 0)
		BEGIN
		SET @success=1
		DELETE FROM Thesis WHERE serialNumber = @ThesisSerialNo
		END
	END
ELSE
	BEGIN
	DECLARE @nonGucianEval INT
	SET @nonGucianEval = (
	SELECT TOP 1 eval
	FROM NonGUCianProgressReport
	WHERE thesisSerialNumber = @ThesisSerialNo
	ORDER BY no DESC
	)
	IF(@nonGucianEval = 0)
		BEGIN
		SET @success=1
		DELETE FROM Thesis WHERE serialNumber = @ThesisSerialNo
		END
	END

GO

CREATE PROC AddGrade
@ThesisSerialNo INT
AS
DECLARE @grade DECIMAL(4,2)
SELECT @grade = grade
FROM Defense
WHERE serialNumber = @ThesisSerialNo
UPDATE Thesis
SET grade = @grade
WHERE serialNumber = @ThesisSerialNo

GO

CREATE PROC AddDefenseGrade
@ThesisSerialNo INT , @DefenseDate DATETIME , @grade DECIMAL(4,2)
AS
UPDATE Defense
SET grade = @grade
WHERE serialNumber = @ThesisSerialNo AND date = @DefenseDate

GO

CREATE PROC AddCommentsGrade
@ThesisSerialNo INT , @DefenseDate DATETIME , @comments VARCHAR(300)
AS
UPDATE ExaminerEvaluateDefense
SET comment = @comments
WHERE serialNo = @ThesisSerialNo AND date = @DefenseDate

GO

CREATE PROC viewMyProfile
@studentId INT
AS
IF(EXISTS(
SELECT * FROM GucianStudent WHERE id = @studentId
))
BEGIN
SELECT G.*,P.email
FROM GucianStudent G
INNER JOIN PostGradUser P
ON G.id = P.id
WHERE G.id = @studentId
END
ELSE
BEGIN
SELECT N.*,P.email
FROM NonGucianStudent N
INNER JOIN PostGradUser P
ON N.id = P.id
WHERE N.id = @studentId
END

GO

CREATE PROC editMyProfile
@studentID INT, @firstName VARCHAR(20), @lastName VARCHAR(20), @password VARCHAR(30), @email
VARCHAR(50) , @address VARCHAR(50) , @type VARCHAR(3)
AS
UPDATE GucianStudent
SET firstName = @firstName, lastName = @lastName, address = @address, type = @type
WHERE id = @studentID
UPDATE NonGucianStudent
SET firstName = @firstName, lastName = @lastName, address = @address, type = @type
WHERE id = @studentID
UPDATE PostGradUser
SET email = @email, password = @password
WHERE id = @studentID

GO

CREATE PROC addUndergradID
@studentID INT, @undergradID VARCHAR(10)
AS
UPDATE GucianStudent
SET undergradID = @undergradID
WHERE id = @studentID

GO

CREATE PROC ViewCoursesGrades
@studentID INT
AS
SELECT c.code ,g.grade
FROM NonGucianStudentTakeCourse g inner join Course c on g.cid = c.id
WHERE g.sid = @studentID

GO

CREATE PROC ViewCoursePaymentsInstall
@studentID INT
AS
SELECT P.id AS 'Payment Number', P.amount AS 'Amount of Payment',P.fundPercentage AS 'Percentage of
fund for payment', P.noOfInstallments AS 'Number of installments',
I.amount AS 'Installment Amount',I.date AS 'Installment date', I.done AS 'Installment done or NOT'
FROM NonGucianStudentPayForCourse NPC
INNER JOIN Payment P
ON NPC.paymentNo = P.id AND NPC.sid = @studentID
INNER JOIN Installment I
ON I.paymentId = P.id

GO

CREATE PROC ViewThesisPaymentsInstall
@studentID INT
AS
SELECT P.id AS 'Payment Number', P.amount AS 'Amount of Payment', P.fundPercentage AS
'Fund',P.noOfInstallments AS 'Number of installments',
I.amount AS 'Installment amount',I.date AS 'Installment date', I.done AS 'Installment done or NOT'
FROM GUCianStudentRegisterThesis G
INNER JOIN Thesis T
ON G.serial_no = T.serialNumber AND G.sid = @studentID
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id
UNION
SELECT P.id AS 'Payment Number',P.amount AS 'Amount of Payment', P.fundPercentage AS
'Fund',P.noOfInstallments AS 'Number of installments',
I.amount AS 'Installment amount',I.date AS 'Installment date', I.done AS 'Installment done or NOT'
FROM NonGUCianStudentRegisterThesis NG
INNER JOIN Thesis T
ON NG.serial_no = T.serialNumber AND NG.sid = @studentID
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id

GO

CREATE PROC ViewUpcomingInstallments
@studentID INT
AS
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Installment I
INNER JOIN NonGucianStudentPayForCourse NPC
ON I.paymentId = NPC.paymentNo AND NPC.sid = @studentID AND I.date > CURRENT_TIMESTAMP
UNION
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Thesis T
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id
INNER JOIN GUCianStudentRegisterThesis G
ON G.serial_no = T.serialNumber AND G.sid = @studentID
WHERE I.date > CURRENT_TIMESTAMP
UNION
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Thesis T
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id
INNER JOIN NonGUCianStudentRegisterThesis G
ON G.serial_no = T.serialNumber AND G.sid = @studentID
WHERE I.date > CURRENT_TIMESTAMP

GO

CREATE PROC ViewMissedInstallments
@studentID INT
AS
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Installment I
INNER JOIN NonGucianStudentPayForCourse NPC
ON I.paymentId = NPC.paymentNo AND NPC.sid = @studentID AND I.date < CURRENT_TIMESTAMP AND
I.done = '0'
UNION
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Thesis T
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id
INNER JOIN GUCianStudentRegisterThesis G
ON G.serial_no = T.serialNumber AND G.sid = @studentID
WHERE I.date < CURRENT_TIMESTAMP AND I.done = '0'
UNION
SELECT I.date AS 'Date of Installment' ,I.amount AS 'Amount'
FROM Thesis T
INNER JOIN Payment P
ON T.payment_id = P.id
INNER JOIN Installment I
ON I.paymentId = P.id
INNER JOIN NonGUCianStudentRegisterThesis G
ON G.serial_no = T.serialNumber AND G.sid = @studentID
WHERE I.date < CURRENT_TIMESTAMP AND I.done = '0'

GO

CREATE PROC AddProgressReport
@thesisSerialNo INT, @progressReportDate date, @studentID INT,@progressReportNo INT
AS
DECLARE @gucian INT
IF(EXISTS(
SELECT id
FROM GucianStudent
WHERE id = @studentID
))
BEGIN
SET @gucian = '1'
END
ELSE
BEGIN
SET @gucian = '0'
END
IF(@gucian = '1')
BEGIN
INSERT INTO GUCianProgressReport
VALUES(@studentID,@progressReportNo,@progressReportDate,NULL,NULL,NULL,@thesisSerialNo,NULL)
END
ELSE
BEGIN
INSERT INTO NonGUCianProgressReport
VALUES(@studentID,@progressReportNo,@progressReportDate,NULL,NULL,NULL,@thesisSerialNo,NULL)
END

GO

CREATE PROC FillProgressReport
@thesisSerialNo INT, @progressReportNo INT, @state INT, @description VARCHAR(200),@studentID INT
AS
DECLARE @gucian BIT
IF(EXISTS(
SELECT * FROM GucianStudent
WHERE id = @studentID
))
BEGIN
SET @gucian = '1'
END
ELSE
BEGIN
SET @gucian = '0'
END
IF(@gucian = '1')
BEGIN
UPDATE GUCianProgressReport
SET state = @state, description = @description, date = CURRENT_TIMESTAMP
WHERE thesisSerialNumber = @thesisSerialNo AND sid = @studentID AND no = @progressReportNo
END
ELSE
BEGIN
UPDATE NonGUCianProgressReport
SET state = @state, description = @description, date = CURRENT_TIMESTAMP
WHERE thesisSerialNumber = @thesisSerialNo AND sid = @studentID AND no = @progressReportNo
END

GO

CREATE PROC stuThesis
@sid INT
AS
IF(EXISTS(SELECT * FROM GucianStudent WHERE id=@sid))
SELECT t.*
FROM GUCianStudentRegisterThesis u inner join Thesis t on u.serial_no = t.serialNumber
WHERE @sid = u.sid
ELSE IF(EXISTS(SELECT * FROM NonGucianStudent WHERE id=@sid))
SELECT t.*
FROM NonGUCianStudentRegisterThesis u inner join Thesis t on u.serial_no = t.serialNumber
WHERE @sid = u.sid

GO

CREATE PROC ViewEvalProgressReport
@thesisSerialNo INT, @progressReportNo INT,@studentID INT
AS
SELECT eval
FROM GUCianProgressReport
WHERE sid = @studentID AND thesisSerialNumber = @thesisSerialNo AND no = @progressReportNo
UNION
SELECT eval
FROM NonGUCianProgressReport
WHERE sid = @studentID AND thesisSerialNumber = @thesisSerialNo AND no = @progressReportNo

GO

CREATE PROC addPublication
@title VARCHAR(50), @pubDate DATETIME, @host VARCHAR(50), @place VARCHAR(50), @accepted BIT
AS
INSERT INTO Publication VALUES(@title,@pubDate,@place,@accepted,@host)

GO

CREATE PROC linkPubThesis
@PubID INT, @thesisSerialNo INT, @success bit output
AS
IF(EXISTS(
select t.serialNumber
FROM thesis t
WHERE t.serialNumber = @thesisSerialNo and  t.endDate > Convert(Date,CURRENT_TIMESTAMP)
))
BEGIN
SET @success = 1
INSERT INTO ThesisHasPublication VALUES(@thesisSerialNo,@PubID)
END
ELSE
BEGIN
SET @success = 0
END

GO

CREATE TRIGGER deleteSupervisor
ON Supervisor
INSTEAD of DELETE
AS
DELETE FROM GUCianProgressReport WHERE supid IN (SELECT id FROM deleted)
DELETE FROM NonGUCianProgressReport WHERE supid IN (SELECT id FROM deleted)
DELETE FROM GUCianStudentRegisterThesis WHERE supid IN (SELECT id FROM deleted)
DELETE FROM NonGUCianStudentRegisterThesis WHERE supid IN (SELECT id FROM deleted)
DELETE FROM Supervisor WHERE id IN (SELECT id FROM deleted)
DELETE FROM PostGradUser WHERE id IN (SELECT id FROM deleted)

--Testing Insertions:

--EXEC studentRegister 'Ahmed', 'Khaled', '123', 'MET' , 1, 'ahmed.gaberdiab@student.guc.edu.eg', 'El Nozha'
--EXEC supervisorRegister 'Misk', 'Mohammed', '420', 'MET', 'misk.abdalla@guc.edu.eg'
--EXEC examinerRegister 'Ali', 'Elserafy', '69', 'MET','ali.serafy@guc.edu.eg', 1
--EXEC studentRegister 'Kiro', 'Khaled', '555', 'MET' , 0, 'kiro.atef@gmail.com', 'El Nozha'

INSERT INTO Admin(id)
VALUES(4)

--INSERT INTO Payment(amount, noOfInstallments, fundPercentage)
--VALUES(12897.32, 4, 23.3)

--INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade, payment_id, noOfExtensions)
--VALUES ('Education','PhD','What are the primary professor’s teaching patterns in China?', '2/1/2016', '3/30/2018', '1/8/2018', 62.3, 1, 1)

--INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade, payment_id, noOfExtensions)
--VALUES ('Education','PhD','What are the primary professor’s teaching patterns in China?', '2/1/2016', '3/30/2018', '1/8/2018', 62.3, 1, 2)

INSERT INTO Thesis(field, type, title, startDate, endDate, defenseDate, grade, payment_id, noOfExtensions)
VALUES ('Education','PhD','What are the primary professor’s teaching patterns in China?', '2/1/2016', '3/30/2018', '1/8/2018', 62.3, 1, 3)

INSERT INTO GUCianStudentRegisterThesis(sid, supid, serial_no)
VALUES (5,7,4)

--INSERT INTO NonGUCianStudentRegisterThesis(sid, supid, serial_no)
--VALUES (4,2,2)

--INSERT INTO Publication(title, dateOfPublication, place, accepted, host)
--VALUES('What are the impacts of intellectual capital in growing markets?', '12/1/2022', 'Cairo', 1, 'Sandra')

--INSERT INTO ThesisHasPublication(serialNo, pubid)
--VALUES(1, 1)

--INSERT INTO GUCianProgressReport(sid, no, date, eval, state, thesisSerialNumber, supid, description)
--VALUES(1, 490, '10/30/2020', null, 10, 1, 2, 'I havent finished')

--INSERT INTO GUCianProgressReport(sid, no, date, eval, state, thesisSerialNumber, supid, description)
--VALUES(1, 491, '11/30/2020', 0, 10, 2, 2, 'I almost finish')

--INSERT INTO Defense(serialNumber, DATE, location, grade)
--VALUES(1, '12/7/2000', 'Cairo', null)

--INSERT INTO ExaminerEvaluateDefense(DATE,serialNo,examinerId,comment)
--VALUES('12/7/2000', 1, 3, null)
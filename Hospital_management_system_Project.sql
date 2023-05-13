-- HOSPITAL MANAGEMENT SYSTEM
-- SQL Projects Questions 

-- Write a query in SQL to find all the information of the nurses who are yet to be registered.

SELECT * FROM NURSE
WHERE REGISTERED = 'f';

-- Write a query in SQL to find the name of the nurse who are the head of their department.

SELECT * FROM NURSE
WHERE POSITION = 'Head Nurse';

-- Write a query in SQL to obtain the name of the physicians who are the head of each department.

SELECT P.NAME,P.POSITION,D.NAME FROM PHYSICIAN P
INNER JOIN DEPARTMENT D
ON P.EMPLOYEEID = D.HEAD;

-- Write a query in SQL to count the number of patients who taken appointment with at least one physician.

SELECT COUNT(DISTINCT PATIENT) FROM APPOINTMENT;

-- Write a query in SQL to find the floor and block where the room number 212 belongs to.

SELECT BLOCKFLOOR AS FLOOR,BLOCKCODE AS CODE FROM ROOM
WHERE ROOMNUMBER  = 212;

-- Write a query in SQL to count the number available rooms

SELECT COUNT(ROOMNUMBER) AS ROOM_AVAILABLE FROM ROOM
WHERE UNAVAILABLE = 'f';

-- Write a query in SQL to count the number of unavailable rooms.

SELECT COUNT(ROOMNUMBER) AS ROOM_AVAILABLE FROM ROOM
WHERE UNAVAILABLE = 't';

-- Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 

SELECT T1.NAME,T3.NAME AS DEPARTMENT
FROM PHYSICIAN T1
INNER JOIN AFFILIATED_WITH T2
ON T1.EMPLOYEEID = T2.PHYSICIAN
INNER JOIN DEPARTMENT T3
ON T2.DEPARTMENT = T3.DEPARTMENTID;

-- Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.

SELECT T1.NAME,T3.NAME,T3.COST
FROM PHYSICIAN T1
INNER JOIN TRAINED_IN T2
ON T1.EMPLOYEEID = T2.PHYSICIAN
INNER JOIN PROCEDURES T3
ON T2.TREATMENT = T3.CODE
ORDER BY T3.COST DESC;

-- Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.

SELECT T1.NAME,T1.POSITION,T3.NAME
FROM PHYSICIAN T1
INNER JOIN AFFILIATED_WITH T2
ON T1.EMPLOYEEID = T2.PHYSICIAN
INNER JOIN DEPARTMENT T3
ON T2.DEPARTMENT = T3.DEPARTMENTID
WHERE T2.PRIMARYAFFILIATION = 'f';


-- Write a query in SQL to obtain the name of the physicians who are not a specialized physician.

SELECT T1.NAME,T1.POSITION
FROM PHYSICIAN T1
LEFT OUTER JOIN TRAINED_IN T2
ON T1.EMPLOYEEID = T2.PHYSICIAN
WHERE T2.TREATMENT IS NULL;


-- Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement. 

SELECT T1.NAME,T1.ADDRESS,T2.NAME
FROM PATIENT T1
LEFT OUTER JOIN PHYSICIAN T2
ON T1.PCP = T2.EMPLOYEEID;


-- Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.

SELECT T2.NAME,COUNT(T1.PHYSICIAN)
FROM APPOINTMENT T1
LEFT OUTER JOIN PATIENT T2
ON T1.PATIENT = T2.SSN
GROUP BY T2.NAME;


-- Write a query in SQL to count number of unique patients who got an appointment for examination room C. 

SELECT COUNT(DISTINCT PATIENT) AS "NO OF UNIQUE PATIENTS"
FROM APPOINTMENT
WHERE EXAMINATIONROOM = 'C';


-- Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment. 

SELECT T1.NAME,T2.EXAMINATIONROOM,T2.STARTO
FROM PATIENT T1
LEFT OUTER JOIN APPOINTMENT T2
ON T1.SSN = T2.PATIENT;


-- Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.

SELECT T1.NAME,T2.EXAMINATIONROOM AS ROOM_NO
FROM NURSE T1
LEFT OUTER JOIN APPOINTMENT T2
ON T1.EMPLOYEEID = T2.PREPNURSE;


-- Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no. (IMP)

SELECT T1.NAME AS PATIENT_NAME,T4.NAME AS PHYSICIAN_NAME,
T3.NAME AS NURSE_NAME,T2.EXAMINATIONROOM AS ROOM,T2.STARTO
FROM PATIENT T1
LEFT OUTER JOIN APPOINTMENT T2
ON T1.SSN = T2.PATIENT
LEFT OUTER JOIN NURSE T3
ON T2.PREPNURSE = T3.EMPLOYEEID
LEFT OUTER JOIN PHYSICIAN T4
ON T2.PHYSICIAN = T4.EMPLOYEEID
WHERE T2.STARTO = '2008-04-24';


-- Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.

SELECT T1.NAME AS PATIENT,
T3.NAME AS PHYSICIAN,
T2.EXAMINATIONROOM AS ROOM
FROM PATIENT T1
LEFT OUTER JOIN APPOINTMENT T2
ON T1.SSN = T2.PATIENT
LEFT OUTER JOIN PHYSICIAN T3
ON T2.PHYSICIAN = T3.EMPLOYEEID
WHERE T2.PREPNURSE IS NULL;


-- Write a query in SQL to find the name of the patients, their treating physicians and medication

SELECT T1.NAME AS PATIENT, T3.NAME AS PHYSICIAN,
T4.NAME AS MEDICATION
FROM PATIENT T1
LEFT OUTER JOIN PRESCRIBES T2
ON T1.SSN = T2.PATIENT
INNER JOIN PHYSICIAN T3
ON T2.PHYSICIAN = T3.EMPLOYEEID
LEFT OUTER JOIN MEDICATION T4
ON T2.MEDICATION = T4.CODE;


-- Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.

SELECT T1.NAME AS PATIENT,T3.NAME AS PHYSICIAN,
T4.NAME AS MEDICATION
FROM PATIENT T1
INNER JOIN PRESCRIBES T2
ON T1.SSN = T2.PATIENT
INNER JOIN PHYSICIAN T3
ON T2.PHYSICIAN = T3.EMPLOYEEID
INNER JOIN MEDICATION T4
ON T2.MEDICATION = T4.CODE;


-- Write a query in SQL to find the name and medication for those patients who did not take any appointment.

SELECT T1.NAME AS PATIENT,T3.NAME AS PHYSICIAN,
T4.NAME AS MEDICATION
FROM PATIENT T1
INNER JOIN PRESCRIBES T2
ON T1.SSN = T2.PATIENT
INNER JOIN PHYSICIAN T3
ON T2.PHYSICIAN = T3.EMPLOYEEID
INNER JOIN MEDICATION T4
ON T2.MEDICATION = T4.CODE
WHERE T2.APPOINTMENT IS NULL;


-- Write a query in SQL to count the number of available rooms in each block.  

SELECT BLOCKCODE AS BLOCK ,COUNT(ROOMNUMBER) 
FROM ROOM
WHERE UNAVAILABLE = 'f'
GROUP BY BLOCKCODE
ORDER BY BLOCKCODE;


-- Write a query in SQL to count the number of available rooms in each floor.

SELECT BLOCKFLOOR AS FLOOR ,COUNT(ROOMNUMBER) 
FROM ROOM
WHERE UNAVAILABLE = 'f'
GROUP BY BLOCKFLOOR
ORDER BY BLOCKFLOOR;


-- Write a query in SQL to count the number of available rooms for each block in each floor. 

SELECT BLOCKFLOOR AS FLOOR,BLOCKCODE AS FLOOR, COUNT(ROOMNUMBER) 
FROM ROOM
WHERE UNAVAILABLE = 'f'
GROUP BY BLOCKFLOOR,BLOCKCODE
ORDER BY BLOCKFLOOR,BLOCKCODE;

-- Write a query in SQL to count the number of unavailable rooms for each block in each floor. 

SELECT BLOCKFLOOR AS FLOOR,BLOCKCODE AS CODE, COUNT(ROOMNUMBER) AS ROOM_UNAVA
FROM ROOM
WHERE UNAVAILABLE = 't'
GROUP BY BLOCKFLOOR,BLOCKCODE
ORDER BY BLOCKFLOOR,BLOCKCODE;


-- Write a query in SQL to find out the floor where the minimum no of rooms are available

SELECT BLOCKFLOOR AS FLOOR ,COUNT(*) AS ROOM
FROM ROOM
WHERE UNAVAILABLE = 'f'
GROUP BY BLOCKFLOOR
LIMIT 1;


-- Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. 

SELECT T2.NAME AS PATIENT, T1.ROOM AS ROOM,
T3.BLOCKCODE AS CODE,
T3.BLOCKFLOOR AS FLOOR
FROM STAY T1
INNER JOIN PATIENT T2
ON T1.PATIENT = T2.SSN
INNER JOIN ROOM T3
ON T1.ROOM = T3.ROOMNUMBER;


-- Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.

SELECT T1.NAME AS NURSE,T2.BLOCKCODE AS BLOCK 
FROM NURSE T1
INNER JOIN ON_CALL T2
ON T1.EMPLOYEEID = T2.NURSE;

-- Write a query in SQL to make a report which will show -
-- a) name of the patient,
-- b) name of the physician who is treating him or her,
-- c) name of the nurse who is attending him or her,
-- d) which treatement is going on to the patient,
-- e) the date of release,
-- f) in which room the patient has admitted and which floor and block the room belongs to respectively.  

SELECT * FROM undergoes;

SELECT 
T2.NAME AS PATIENT, T3.NAME AS PHYSICIAN,
T4.NAME AS NURSE, T1.DATEUNDERGOES AS DATES, T6.ROOMNUMBER AS ROOM,
T6.BLOCKFLOOR AS FLOOR, T6.BLOCKCODE AS CODE
FROM UNDERGOES T1
INNER JOIN PATIENT T2
ON T1.PATIENT = T2.SSN
INNER JOIN PHYSICIAN T3
ON T1.PHYSICIAN = T3.EMPLOYEEID
INNER JOIN NURSE T4
ON T1.ASSISTINGNURSE = T4.EMPLOYEEID
INNER JOIN STAY T5
ON T1.PATIENT = T5.PATIENT
INNER JOIN ROOM T6
ON T5.ROOM = T6.ROOMNUMBER;

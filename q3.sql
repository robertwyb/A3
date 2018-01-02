DROP TABLE IF EXISTS q3 CASCADE;

CREATE TABLE q3(
	sid varchar(11),
	last_name varchar(50),
	total_grade int
);

DROP VIEW IF EXISTS getclass CASCADE;
DROP VIEW IF EXISTS getsid CASCADE;
DROP VIEW IF EXISTS getqzid CASCADE;
DROP VIEW IF EXISTS getweight CASCADE;
DROP VIEW IF EXISTS mctrue CASCADE;
DROP VIEW IF EXISTS numtrue CASCADE;
DROP VIEW IF EXISTS tftrue CASCADE;
DROP VIEW IF EXISTS marksheet CASCADE;
DROP VIEW IF EXISTS totalmark CASCADE;
DROP VIEW IF EXISTS result CASCADE;

/*get class id based on grade, room and teacher*/
CREATE VIEW getclass AS
SELECT cid, rid FROM Class
WHERE Class.grade  = 8 AND Class.rid = 120;

CREATE VIEW getteacher AS
SELECT cid, teacher FROM getclass, Room
WHERE getclass.rid = Room.rid;

/* get all student in that class*/
CREATE VIEW getsid AS
SELECT sid FROM getteacher 
INNER JOIN Enrol ON getteacher.cid = Enrol.cid;

CREATE VIEW getsinfo AS 
SELECT Student.sid, last_name 
FROM getsid INNER JOIN Student on Student.sid = getsid.sid;

CREATE VIEW getqzid AS
SELECT qzid
FROM Quiz 
WHERE qzid = 'Pr1-220310';

/* get weight of all questions in that quiz*/
CREATE VIEW getweight AS
SELECT qid, weight 
FROM Qz_enr INNER JOIN getqzid ON Qz_enr.qzid = getqzid.qzid;

/* get all student who answer multiple choice questions right*/
CREATE VIEW mctrue AS
SELECT Mc_record.sid, Mc_record.qid, weight
FROM Mc_record 
	INNER JOIN McT ON Mc_record.qid = McT.qid AND Mc_record.record = McT.mc_ans
	INNER JOIN getsinfo ON Mc_record.sid = getsinfo.sid
	INNER JOIN getweight ON getweight.qid = Mc_record.qid;

/* get all student who answer numerical questions right*/
CREATE VIEW numtrue AS
SELECT Num_record.sid, Num_record.qid, weight
FROM Num_record 
	INNER JOIN NumT ON Num_record.qid = NumT.qid AND Num_record.record = NumT.Num_ans
	INNER JOIN getsinfo on Num_record.sid = getsinfo.sid
	INNER JOIN getweight ON getweight.qid = Num_record.qid;

/* get all student who answer true-false questions right*/
CREATE VIEW tftrue AS
SELECT Tf_record.sid, Tf_record.qid, weight
FROM Tf_record 
	INNER JOIN TfT ON Tf_record.qid = TfT.qid AND Tf_record.record = TfT.Tf_ans
	INNER JOIN getsinfo on Tf_record.sid = getsinfo.sid
	INNER JOIN getweight ON getweight.qid =Tf_record.qid;


CREATE VIEW marksheet AS
(SELECT * FROM mctrue)
	UNION
(SELECT * FROM numtrue)
	UNION
(SELECT * FROM tftrue);

/* get students who get 0 as total mark */
CREATE VIEW nomark AS
SELECT sid, 0 AS total FROM getsinfo 
WHERE sid NOT IN (SELECT sid FROM marksheet);

CREATE VIEW totalmark AS
(SELECT sid, sum(weight) AS total
FROM marksheet
GROUP BY sid)
    UNION
(SELECT * FROM nomark);

/*combine mark with student info*/
CREATE VIEW result AS
SELECT getsinfo.sid, last_name, total
FROM getsinfo INNER JOIN totalmark ON getsinfo.sid = totalmark.sid;

INSERT INTO q3(sid, last_name, total_grade)
(SELECT sid, last_name, total AS total_grade FROM result);
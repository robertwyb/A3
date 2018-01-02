DROP TABLE IF EXISTS q4 CASCADE;

CREATE TABLE q4(
	sid varchar(11),
	qid int,
	qtext varchar(500)
);

DROP VIEW IF EXISTS getclass CASCADE;
DROP VIEW IF EXISTS getsid CASCADE;
DROP VIEW IF EXISTS getqzid CASCADE;
DROP VIEW IF EXISTS getallst CASCADE;
DROP VIEW IF EXISTS getmc CASCADE;
DROP VIEW IF EXISTS getnum CASCADE;
DROP VIEW IF EXISTS gettf CASCADE;
DROP VIEW IF EXISTS allans CASCADE;
DROP VIEW IF EXISTS result CASCADE;
DROP VIEW IF EXISTS result1 CASCADE;

/*get class id based on grade, room and teacher*/
CREATE VIEW getclass AS
SELECT cid, rid FROM Class
WHERE Class.grade  = 8 AND Class.rid = 120;

CREATE VIEW getteacher AS
SELECT cid, teacher FROM getclass, Room
WHERE getclass.rid = Room.rid;

/* get all student in that class*/
CREATE VIEW getsid AS
SELECT sid, Enrol.cid FROM getclass 
INNER JOIN Enrol ON getclass.cid = Enrol.cid;

CREATE VIEW getallst AS
SELECT sid, qid 
FROM Quiz 
	INNER JOIN Qz_enr ON Quiz.qzid = Qz_enr.qzid
	INNER JOIN getsid ON getsid.cid = Quiz.cid
WHERE Quiz.qzid = 'Pr1-220310';

/*get all recorded answered question is with corresponding student id*/
CREATE VIEW getmc AS
SELECT sid, qid
FROM Mc_record 
WHERE qzid = 'Pr1-220310' AND record != 'no answer';

CREATE VIEW getnum AS
SELECT sid, qid
FROM Num_record 
WHERE qzid = 'Pr1-220310';

CREATE VIEW gettf AS
SELECT sid, qid
FROM Tf_record 
WHERE qzid = 'Pr1-220310';

/* combine three types of answered questions together*/
CREATE VIEW allans AS
(SELECT * FROM getmc)
	UNION
(SELECT * FROM getnum)
	UNION
(SELECT * FROM gettf);

/* get all quetions that are not answered*/
CREATE VIEW result AS
(SELECT * FROM getallst)
	EXCEPT
(SELECT * FROM allans);

CREATE VIEW result1 AS
SELECT result.sid, result.qid, Questions.qtext
FROM result 
	INNER JOIN Questions ON result.qid = Questions.qid;

INSERT INTO q4(sid, qid, qtext)
(SELECT sid, qid, qtext FROM result1);
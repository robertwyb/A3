DROP TABLE IF EXISTS q5 CASCADE;

CREATE TABLE q5(
	qid int,
	y int,
	f int,
	n int
);

DROP VIEW IF EXISTS getclass CASCADE;
DROP VIEW IF EXISTS getsid CASCADE;
DROP VIEW IF EXISTS getqzid CASCADE;
DROP VIEW IF EXISTS getallst CASCADE;
DROP VIEW IF EXISTS mctrue CASCADE;
DROP VIEW IF EXISTS numtrue CASCADE;
DROP VIEW IF EXISTS tftrue CASCADE;
DROP VIEW IF EXISTS alltrue CASCADE;
DROP VIEW IF EXISTS counttrue CASCADE;
DROP VIEW IF EXISTS mcfalse CASCADE;
DROP VIEW IF EXISTS numfalse CASCADE;
DROP VIEW IF EXISTS tffalse CASCADE;
DROP VIEW IF EXISTS allfalse CASCADE;
DROP VIEW IF EXISTS countfalse CASCADE;
DROP VIEW IF EXISTS allnot CASCADE;
DROP VIEW IF EXISTS countnot CASCADE;
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
SELECT sid, Enrol.cid FROM getclass 
INNER JOIN Enrol ON getclass.cid = Enrol.cid;

CREATE VIEW getallst AS
SELECT qid, sid
FROM Quiz 
	INNER JOIN Qz_enr ON Quiz.qzid = Qz_enr.qzid
	INNER JOIN getsid ON getsid.cid = Quiz.cid
WHERE Quiz.qzid = 'Pr1-220310';

CREATE VIEW mctrue AS
SELECT Mc_record.sid, Mc_record.qid
FROM Mc_record 
	INNER JOIN McT ON Mc_record.qid = McT.qid AND Mc_record.record = McT.mc_ans
	INNER JOIN getsid ON Mc_record.sid = getsid.sid;

CREATE VIEW numtrue AS
SELECT Num_record.sid, Num_record.qid
FROM Num_record 
	INNER JOIN NumT ON Num_record.qid = NumT.qid AND Num_record.record = NumT.Num_ans
	INNER JOIN getsid on Num_record.sid = getsid.sid;
	
CREATE VIEW tftrue AS
SELECT Tf_record.sid, Tf_record.qid
FROM Tf_record 
	INNER JOIN TfT ON Tf_record.qid = TfT.qid AND Tf_record.record = TfT.Tf_ans
	INNER JOIN getsid on Tf_record.sid = getsid.sid;

CREATE VIEW alltrue AS
(SELECT qid, sid FROM mctrue)
	UNION
(SELECT qid, sid FROM numtrue)
	UNION
(SELECT qid, sid FROM tftrue);

/* get how many students answer the questions right*/
CREATE VIEW counttrue AS
SELECT qid, count(sid) AS c 
FROM alltrue
GROUP BY qid;

CREATE VIEW mcfalse AS
(SELECT getsid.sid, qid FROM Mc_record INNER JOIN getsid ON Mc_record.sid = getsid.sid 
WHERE Mc_record.record != 'no answer')
	EXCEPT
(SELECT * FROM mctrue);

CREATE VIEW numfalse AS
(SELECT getsid.sid, qid FROM Num_record INNER JOIN getsid ON Num_record.sid = getsid.sid)
	EXCEPT
(SELECT * FROM numtrue);

CREATE VIEW tffalse AS
(SELECT getsid.sid, qid FROM Tf_record INNER JOIN getsid ON Tf_record.sid = getsid.sid)	
	EXCEPT
(SELECT * FROM tftrue);

CREATE VIEW allfalse AS
(SELECT qid, sid FROM mcfalse)
	UNION
(SELECT qid, sid FROM numfalse)
	UNION
(SELECT qid, sid FROM tffalse);

/* get how many students don't answer the questions right*/
CREATE VIEW countfalse AS
SELECT qid, count(sid) AS c
FROM allfalse 
GROUP BY qid;

CREATE VIEW allnot AS
(SELECT * FROM getallst)
	EXCEPT
(SELECT * FROM alltrue)
	EXCEPT
(SELECT * FROM allfalse);

/* get how many students don't answer the questions at all*/
CREATE VIEW countnot AS
SELECT qid, count(sid) AS c
FROM allnot GROUP BY qid;

/* combine all informations to same table */
CREATE VIEW result AS
SELECT counttrue.qid, counttrue.c AS y, countfalse.c AS f, countnot.c AS n
FROM counttrue 
	INNER JOIN countfalse ON counttrue.qid = countfalse.qid
	INNER JOIN countnot ON counttrue.qid = countnot.qid;
	
CREATE VIEW result1 AS
SELECT counttrue.qid, counttrue.c AS y, countfalse.c AS f, 0 AS n
FROM counttrue, countfalse, countnot
WHERE counttrue.qid = countfalse.qid 
AND counttrue.qid NOT IN (SELECT qid FROM countnot);

CREATE VIEW final AS 
(SELECT * FROM result)
    UNION
(SELECT * FROM result1);


INSERT INTO q5(qid, y, f, n)
(SELECT qid as qid, y as y, f as f, n as n
FROM final);
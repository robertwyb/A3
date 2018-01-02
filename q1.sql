<!DOCTYPE html>
<html>
<body>
<pre>DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q1(
	StudentNumber varchar(11),
	StudentName varchar(100)
);

DROP VIEW IF EXISTS sinfo CASCADE;

/* get student number and their names from Student table*/

CREATE VIEW sinfo AS
SELECT sid AS StudentNumber, first_name ||&#39; &#39;|| last_name AS StudentName
FROM Student;

INSERT INTO q1(StudentNumber, StudentName)
(SELECT * FROM sinfo);</pre>
</body>
</html>

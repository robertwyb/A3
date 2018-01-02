DROP TABLE IF EXISTS q2 CASCADE;


CREATE TABLE q2(
	qid int,
	qtext varchar(500),
	hintnum int
);

DROP VIEW IF EXISTS mcinfo CASCADE;
DROP VIEW IF EXISTS numinfo CASCADE;
DROP VIEW IF EXISTS mchint CASCADE;
DROP VIEW IF EXISTS numhint CASCADE;
DROP VIEW IF EXISTS tfinfo CASCADE;
DROP VIEW IF EXISTS mc CASCADE;
DROP VIEW IF EXISTS num CASCADE;
DROP VIEW IF EXISTS result CASCADE;

/* get question id and text based on their type*/

CREATE VIEW mcinfo AS
SELECT qid, qtext
FROM Questions 
WHERE type = 'Multiple-choice';

CREATE VIEW numinfo AS
SELECT qid, qtext
FROM Questions 
WHERE type = 'Numeric';

/*count how many hint does this type of questions have*/
CREATE VIEW mchint AS
SELECT qid, count(hint) AS hintnum
FROM McF
GROUP BY qid;

CREATE VIEW numhint AS
SELECT qid, count(hint) AS hintnum
FROM NumF
GROUP BY qid;

/* get question id text and null as hintnum for True-False question since there is no hint
for True-False question*/
CREATE VIEW tfinfo AS
SELECT qid, qtext, NULL AS hintnum
FROM Questions 
WHERE type = 'True-False';

/* combine question text with question hint count */
CREATE VIEW mc AS 
SELECT mcinfo.qid, qtext, mchint.hintnum
FROM mcinfo INNER JOIN mchint ON mcinfo.qid = mchint.qid;

CREATE VIEW num AS 
SELECT numinfo.qid, qtext, numhint.hintnum
FROM numinfo INNER JOIN numhint ON numinfo.qid = numhint.qid;

CREATE VIEW result AS
(SELECT * FROM mc)
	UNION
(SELECT * FROM num)
	UNION
(SELECT * FROM tfinfo);


INSERT INTO q2(qid, qtext, hintnum)
(SELECT * FROM result);
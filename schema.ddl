-- constraints that cannot be enforced:
--    There must be at least one student in each class
--    There must be at least two options for multiple choice questions.
--constraints that can be enforced
--    Seperate hint table to add NOT NULL constraint for questions that have hint
--    Only student assigned to quiz can do the quiz
--    Do these will produce lots of redundant data, so not worth to enforce these constraints.
    





drop schema if exists quizschema cascade;
create schema quizschema;
set search_path to quizschema;

CREATE TABLE Student (
	sid varchar(11),
	first_name varchar(20),
	last_name varchar(20),
	PRIMARY KEY (sid)
		
);

CREATE TABLE Class (
	cid INT,
	rid INT,
	grade INT,
	PRIMARY KEY (cid)
);

CREATE TABLE Enrol (
	sid varchar(11),
	cid int,
	PRIMARY KEY (sid,cid)
);

CREATE TABLE Room (
	rid INT,
	teacher varchar(40),
	PRIMARY KEY (rid)
);

CREATE TABLE Questions (
	qid INT,
	type varchar(20),
	qtext varchar(200),
	PRIMARY KEY (qid)
);

CREATE TABLE McT (
	qid INT,
	mc_ans varchar(100),
	PRIMARY KEY (qid)
);

CREATE TABLE NumT (
	qid INT,
	num_ans INT,
	PRIMARY KEY (qid)
);

CREATE TABLE TfT (
	qid INT,
	tf_ans varchar(10),
	PRIMARY KEY (qid)
);

CREATE TABLE McF (
	qid INT,
	options varchar(100),
	hint varchar(100),
	PRIMARY KEY (qid, options)
);

CREATE TABLE NumF (
	qid INT,
	lb INT,
	ub INT,
	hint varchar(100),
	PRIMARY KEY (qid, lb, ub)
);

CREATE TABLE Quiz (
	qzid varchar(50),
	title varchar(100),
	dtime varchar(50),
	ddate varchar(50),
	cid INT,
	hintset varchar,
	PRIMARY KEY (qzid)
);

CREATE TABLE Qz_enr (
	qzid varchar,
	qid INT,
	weight INT,
	PRIMARY KEY (qzid,qid)
);



CREATE TABLE Mc_record (
	sid varchar(11),
	qzid varchar(50),
	qid INT,
	record varchar(100),
	PRIMARY KEY (sid,qzid,qid)
);

CREATE TABLE Tf_record (
	sid varchar(11),
	qzid varchar(50),
	qid INT,
	record varchar(100),
	PRIMARY KEY (sid,qzid,qid)
);

CREATE TABLE Num_record (
	sid varchar(11),
	qzid varchar(50),
	qid INT,
	record INT,
	PRIMARY KEY (sid,qzid,qid)
);
